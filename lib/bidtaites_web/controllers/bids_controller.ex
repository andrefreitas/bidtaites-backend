defmodule BidtaitesWeb.BidsController do
  use BidtaitesWeb, :controller

  alias Bidtaites.Interactors.CreateBid
  alias Bidtaites.Interactors.ListBids
  alias Bidtaites.Interactors.UpdateBid

  def create(conn, params) do
    json(conn, CreateBid.call(params))
  end

  def list(conn, %{"auction_id" => auction_id}) do
    json(conn, ListBids.call(auction_id))
  end

  def callback(conn, %{"resource" => %{"reference" => order_id}}) do
    case UpdateBid.call(order_id, "paid") do
      {:ok, _} -> put_status(conn, 200) |> json(%{})
      _ -> put_status(conn, 400) |> json(%{error: "failed to update"})
    end
  end
end
