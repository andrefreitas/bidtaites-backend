defmodule Bidtaites.Interactors.ListBids do
  alias Bidtaites.Repo.Bids

  def call(auction_id) do
    Bids.all(auction_id)
  end
end
