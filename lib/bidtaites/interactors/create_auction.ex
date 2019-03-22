defmodule Bidtaites.Interactors.CreateAuction do
  alias Bidtaites.Repo.Auctions

  def call(auction) do
    auction_with_uuid =
      Map.merge(auction, %{
        uuid: UUID.uuid4(),
        end_at: DateTime.utc_now() |> DateTime.to_unix()
      })

    case Auctions.insert(auction_with_uuid) do
      {:ok, _} -> auction_with_uuid
      {:error, _} -> %{error: "error creating auction"}
    end
  end
end
