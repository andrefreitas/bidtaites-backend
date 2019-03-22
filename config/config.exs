# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bidtaites, Bidtaites.Repo,
  database: "d1q9pt7aok0jfo",
  username: "twgqxtkwcpvfhe",
  password: "3f7fb726ed76c57f1313d58a0c25b6702a640067bdda0fbaac9a8effe955a3f4",
  hostname: "ec2-54-247-70-127.eu-west-1.compute.amazonaws.com"

config :bidtaites,
  ecto_repos: [Bidtaites.Repo]

# Configures the endpoint
config :bidtaites, BidtaitesWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Y2ChiMZEtzvj/m/kAkq+s3PSZ8RqHfLXm9w1wB9qbpdHYeRsTn85e6nM0VeFNNne",
  render_errors: [view: BidtaitesWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Bidtaites.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
