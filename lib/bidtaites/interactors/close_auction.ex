defmodule Bidtaites.Interactors.CloseAuction do
  alias Bidtaites.Repo.Auctions

  def call(auction_id, status) do
    auction = %{
      id: auction_id,
      status: status
    }

    case Auctions.update(auction) do
      {:ok, auction} -> {:ok, auction}
      {:error, _} -> %{error: "error closing auction"}
    end
  end
end
