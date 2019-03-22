defmodule Bidtaites.Interactors.CreateBid do
  alias Bidtaites.Repo.Bids

  def call(bid) do
    # TODO
    # (1) Check if `auction_id` exists
    # (2) Create utrust order and fetch the `order_id`
    # (3) Check if there's a current bid for this email and decrement `paid`
    #     | value | paid |
    #     |--------------|
    #     | 20    | 20   |
    #     | 50    | 30   |
    # (4) Persist a new bid with `order_id`
    
    bid_with_status = Map.merge(bid, %{"status" => "pending"})

    case Bids.insert(bid_with_status) do
      {:ok, _} -> bid_with_status
      {:error, _} -> %{error: "error creating bid"}
    end
  end
end
