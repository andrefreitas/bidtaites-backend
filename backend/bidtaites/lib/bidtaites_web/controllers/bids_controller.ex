defmodule BidtaitesWeb.BidsController do
  use BidtaitesWeb, :controller

  alias Bidtaites.Interactors.CreateBid
  alias Bidtaites.Interactors.ListBids

  def create(conn, %{"id" => id} = params) do
    json(conn, CreateBid.call)
  end

  def list(conn, %{"id" => id}) do
    json(conn, ListBids.call(id))
  end
end
