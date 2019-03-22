defmodule Bidtaites.Repo.Bids do
  use Ecto.Schema
  
  schema "bids" do
    field :auction_id, :string
    field :order_id, :string
    field :value, :integer
    field :paid, :integer
    field :email, :string
    field :status, :string
    
    timestamps()
  end

  import Ecto.Query
  import Ecto.Changeset
  alias Bidtaites.Repo

  def all(id) do
    __MODULE__
    |> where(auction_id: ^id)
    |> Repo.all
  end

  def insert(bid = %{}) do
    %__MODULE__{}
    |> cast(bid, [:auction_id, :order_id, :value, :paid, :email, :status])
    |> Repo.insert
  end

  def get(email) do
    __MODULE__
    |> where(email: ^email)
    |> Repo.all
  end
end
