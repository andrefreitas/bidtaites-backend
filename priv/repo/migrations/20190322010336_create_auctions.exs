defmodule Bidtaites.Repo.Migrations.CreateAuctions do
  use Ecto.Migration

  def change do
    create table(:auctions) do
      add :uuid, :string
      add :title, :string
      add :email, :string
      add :price, :integer
      add :photo, :string
      add :description, :string
      add :phone_number, :string
      add :end_at, :integer
      add :status, :string
      add :max_bid, :string

      timestamps()
    end
  end
end
