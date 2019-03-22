defmodule Bidtaites.Interactors.CreateAuction do
  alias Bidtaites.Repo.Auctions

  def call(auction) do
    uuid = UUID.uuid4()

    auction_with_uuid =
      Map.merge(auction, %{
        uuid: uuid,
        status: "OPEN"
      })

    IO.inspect auction_with_uuid

    %{end_at: end_at} = auction_with_uuid

    #auction_with_uuid = Map.merge(auction_with_uuid, %{end_at: end_at})

    #IO.inspect auction_with_uuid

    case Auctions.insert(auction_with_uuid) do
      {:ok, _} ->
        {:ok, _} = Bidtaites.Refund.DynamicSupervisor.start_child(%{uuid: uuid, end_at: end_at})
        auction_with_uuid
      {:error, _} -> %{error: "error creating auction"}
    end
  end
end
