defmodule Bidtaites.Interactors.CreateBid do
  alias Bidtaites.Repo.Bids

  def call do
    Bids.insert(%{email: "luisfmcalado@gmail.com"})

    %{id: UUID.uuid4()}
  end
end
