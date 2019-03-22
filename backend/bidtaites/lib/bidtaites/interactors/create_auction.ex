defmodule Bidtaites.Interactors.CreateAuction do
  alias Bidtaites.Repo.Auctions

  def call do
    Auctions.insert(%{email: "luisfmcalado@gmail.com", updated_at: DateTime.utc_now})

    %{id: UUID.uuid4()}
  end
end
