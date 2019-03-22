defmodule Bidtaites.Interactors.CreateBid do
  alias Bidtaites.Repo.Bids
  alias Bidtaites.Gateway.Utrust

  require Logger

  def call(%{"auction_id" => auction_id, "value" => value} = bid) do
    {val, _} = Integer.parse(value)

    case Bids.last(auction_id) do
      nil -> bid_correct(bid)
      max_bid when max_bid.value < val -> bid_correct(bid)
      _ -> %{error: "error creating bid: bid lower than value."}
    end

  end

  defp bid_correct(%{"auction_id" => auction_id, "email" => email, "value" => value} = bid) do
    {val, _} = Integer.parse(value)

    paid =
    case Bids.last(auction_id, email) do
      nil -> value
      lst -> val - lst.value
    end

    ref_id = UUID.uuid4

    {:ok, %{"data" => %{"attributes" => %{"token" => token}}}} = Utrust.store_session
    {:ok, %{
      "data" => %{
      "attributes" => %{
      "redirect_url" => pay_redirect
    },
    "id" => order_id,
    "type" => "orders_redirect"
  }
    }} = Utrust.create_order(token, value, ref_id, email)

    bid_with_status = Map.merge(bid, %{
          "status" => "pending",
          "order_id" => order_id,
          "paid" => paid,
          "ref_id" => ref_id
                                })

    case Bids.insert(bid_with_status) do
      {:ok, _} -> Map.merge(bid_with_status, %{redirect: pay_redirect})
      {:error, error} ->
        Logger.error("#{inspect error}")
        %{error: "error creating bid"}
    end
  end
end
