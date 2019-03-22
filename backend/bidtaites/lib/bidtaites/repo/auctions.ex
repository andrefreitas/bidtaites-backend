defmodule Bidtaites.Repo.Auctions do
  use Ecto.Schema

  schema "auctions" do
    field :title, :string
    field :email, :string
    field :price, :integer
    field :photo, :string
    field :description, :string
    field :phone_number, :string
  end

  import Ecto.Query
  import Ecto.Changeset
  alias Bidtaites.Repo

  @permitted_fields ~w(email)a

  def all do
    Repo.all(from n in __MODULE__)
  end

  def insert(auction = %{}) do
    %__MODULE__{}
    |> cast(auction, @permitted_fields)
    |> Repo.insert!
  end

  def get(id) do
    Repo.get!(__MODULE__, id)
  end

  def update(%{id: id} = auction) do
    Repo.get!(__MODULE__, id)
    |> cast(auction, @permitted_fields)
    |> Repo.update!
  end

  def delete(id) do
    Repo.get!(__MODULE__, id)
    |> Repo.delete!
  end
end
