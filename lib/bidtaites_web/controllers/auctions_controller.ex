defmodule BidtaitesWeb.AuctionsController do
  use BidtaitesWeb, :controller

  alias Bidtaites.Interactors.{
    CreateAuction,
    ListAuctions
    }

  def create(conn, params) do
    auction = %{
      email: params["email"],
      title: params["title"],
      description: params["description"],
      price: params["price"],
      photo: params["photo"],
      phone_number: params["phone_number"]
    }

    json(conn, CreateAuction.call(auction))
  end

  def list(conn, _) do
    json(conn, ListAuctions.call)
  end
end
