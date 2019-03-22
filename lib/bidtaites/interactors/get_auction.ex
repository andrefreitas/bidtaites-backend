defmodule Bidtaites.Interactors.GetAuction do
  alias Bidtaites.Repo.Auctions
  alias Bidtaites.Repo.Bids

  def call(id) do
    %{uuid: uuid} = auction = Auctions.get(id)

    max_bid =
    case  Bids.max_bid(uuid) do
      [] -> 0
      nil -> 0
      [v] -> v
    end

    Map.put(auction, :max_bid, max_bid)
  end
end
