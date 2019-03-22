defmodule Bidtaites.Interactors.GetAuction do
  alias Bidtaites.Repo.Auctions

  def call(id) do
    Auctions.get(id)
  end
end
