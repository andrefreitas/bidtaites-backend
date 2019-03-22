defmodule Bidtaites.Interactors.CreateAuction do
  alias Bidtaites.Repo.Auctions

  def call(auction) do
    uuid = UUID.uuid4()
    end_at = (DateTime.utc_now() |> DateTime.to_unix()) + 1800

    auction_with_uuid =
      Map.merge(auction, %{
        uuid: uuid,
        end_at: end_at,
        status: "OPEN"
      })

    case Auctions.insert(auction_with_uuid) do
      {:ok, _} ->
        {:ok, _} = Bidtaites.Refund.DynamicSupervisor.start_child(%{uuid: uuid, end_at: end_at})
        auction_with_uuid
      {:error, _} -> %{error: "error creating auction"}
    end
  end
end
