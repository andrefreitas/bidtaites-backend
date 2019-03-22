defmodule Bidtaites.Repo.Migrations.UpdateBidsTable do
  use Ecto.Migration

  def up do
    alter table(:bids) do
      modify :inserted_at, :naive_datetime, default: fragment("NOW()")
      modify :updated_at, :naive_datetime, default: fragment("NOW()")
    end
  end
end
