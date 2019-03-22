defmodule BidtaitesWeb.AuctionsController do
  use BidtaitesWeb, :controller

  alias Bidtaites.Interactors.CreateAuction

  def create(conn, params) do

    json(conn, CreateAuction.call)
  end
end
