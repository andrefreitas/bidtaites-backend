defmodule Bidtaites.Repo.Migrations.CreateBids do
  use Ecto.Migration

  def change do
    create table(:bids) do
      add :auction_id, :string
      add :order_id, :string
      add :value, :integer
      add :paid, :integer
      add :email, :string
      add :status, :string
      add :ref_id, :string

      timestamps()
    end

  end
end
