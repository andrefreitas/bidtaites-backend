defmodule Bidtaites.Repo.Migrations.UpdateAuctionsTable do
  use Ecto.Migration

  def up do
    alter table(:auctions) do
      modify :inserted_at, :naive_datetime, default: fragment("NOW()")
      modify :updated_at, :naive_datetime, default: fragment("NOW()")
    end
  end
end
