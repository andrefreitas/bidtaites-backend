defmodule Bidtaites.Interactors.CreateBid do
  alias Bidtaites.Repo.Bids

  alias Bidtaites.Gateway.Utrust

  def call(%{"auction_id" => auction_id, "email" => email, "value" => value} = bid) do
    # TODO
    # (2) Create utrust order and fetch the `order_id`
    # (3) Check if there's a current bid for this email and decrement `paid`
    #     | value | paid |
    #     |--------------|
    #     | 20    | 20   |
    #     | 50    | 30   |

    {:ok, %{"data" => %{"attributes" => %{"token" => token}}}} = Utrust.store_session
    {:ok, %{
      "data" => %{
    "attributes" => %{
  "redirect_url" => pay_redirect
},
    "id" => order_id,
    "type" => "orders_redirect"
  }
    }} = Utrust.create_order(token, value, auction_id, email)

        bid_with_status = Map.merge(bid, %{
              "status" => "pending",
              "order_by" => order_id
                                    })

    case Bids.insert(bid_with_status) do
      {:ok, _} -> Map.merge(bid_with_status, %{redirect: pay_redirect})
      {:error, _} -> %{error: "error creating bid"}
    end
  end
end
