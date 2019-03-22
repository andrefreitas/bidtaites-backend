defmodule BidtaitesWeb.Router do
  use BidtaitesWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BidtaitesWeb do
    pipe_through :api

    post "/auctions", AuctionsController, :create
    get "/auctions", AuctionsController, :list
  end
end
