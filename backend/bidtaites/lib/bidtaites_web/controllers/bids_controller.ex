defmodule BidtaitesWeb.BidsController do
  use BidtaitesWeb, :controller

  alias Bidtaites.Interactors.CreateBid

  def create(conn, params) do

    json(conn, CreateBid.call)
  end
end
