defmodule Bidtaites.Interactors.UpdateBid do
  alias Bidtaites.Repo.Bids

  def call(order_id, status) do
    bid = %{
      order_id: order_id,
      status: status
    }

    case Bids.update(bid) do
      {:ok, bid} -> {:ok, bid}
      {:error, _} -> %{error: "error updating bid"}
    end
  end
end
