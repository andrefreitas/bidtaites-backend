defmodule Bidtaites.Interactors.UpdateBid do
  alias Bidtaites.Repo.Bids

  def call(ref_id, status) do
    bid = %{
      ref_id: ref_id,
      status: status
    }

    case Bids.update(bid) do
      {:ok, bid} -> {:ok, bid}
      {:error, _} -> %{error: "error updating bid"}
    end
  end
end
