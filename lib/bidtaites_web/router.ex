defmodule BidtaitesWeb.Router do
  use BidtaitesWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BidtaitesWeb do
    pipe_through :api

    post "/auctions", AuctionsController, :create
    get "/auctions", AuctionsController, :list
    get "/auctions/:id", AuctionsController, :fetch

    post "/auctions/:auction_id/bids", BidsController, :create
    get "/auctions/:auction_id/bids", BidsController, :list
  end
end
