defmodule BidtaitesWeb.BidsController do
  use BidtaitesWeb, :controller

  alias Bidtaites.Interactors.CreateBid
  alias Bidtaites.Interactors.ListBids

  def create(conn, params) do
    json(conn, CreateBid.call(params))
  end

  def list(conn, %{"auction_id" => auction_id}) do
    json(conn, ListBids.call(auction_id))
  end
end
