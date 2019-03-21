defmodule Bidtaites.Repo do
  use Ecto.Repo,
    otp_app: :bidtaites,
    adapter: Ecto.Adapters.Postgres
end
