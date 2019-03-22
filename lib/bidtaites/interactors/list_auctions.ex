defmodule Bidtaites.Interactors.ListAuctions do
  alias Bidtaites.Repo.Auctions

  def call do
    Auctions.all()
  end
end
