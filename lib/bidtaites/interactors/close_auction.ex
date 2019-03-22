defmodule Bidtaites.Interactors.CloseAuction do
  alias Bidtaites.Repo.Auctions
  alias Bidtaites.Repo.Bids
  alias Bidtaites.Gateway.Utrust

  def call(auction_id, status) do
    auction = %{
      id: auction_id,
      status: status
    }

    {:ok, %{"data" => %{"attributes" => %{"token" => token}}}} = Utrust.session

    auction_id
    |> Bids.refunds
    |> Enum.each(&Utrust.refund(token, &1.order_id, &1.value))

    case Auctions.update(auction) do
      {:ok, auction} -> {:ok, auction}
      {:error, _} -> %{error: "error closing auction"}
    end
  end
end
