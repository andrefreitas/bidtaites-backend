defmodule Bidtaites.Repo.Auctions do
  use Ecto.Schema

  @derive {Jason.Encoder, except: [:__meta__]}
  schema "auctions" do
    field :uuid, :string
    field :title, :string
    field :email, :string
    field :price, :integer
    field :photo, :string
    field :description, :string
    field :phone_number, :string
    field :end_at, :integer
  end

  import Ecto.Query
  import Ecto.Changeset
  alias Bidtaites.Repo

  @permitted_fields ~w(
    uuid
    email
    title
    price
    photo
    description
    phone_number
    end_at
  )a

  def all do
    Repo.all(from n in __MODULE__)
  end

  def insert(auction = %{}) do
    %__MODULE__{}
    |> cast(auction, @permitted_fields)
    |> Repo.insert
  end

  def get(id) do
    Repo.get_by(__MODULE__, uuid: id)
  end

  def update(%{id: id} = auction) do
    get(id)
    |> cast(auction, @permitted_fields)
    |> Repo.update
  end

  def delete(id) do
    Repo.get!(__MODULE__, id)
    |> Repo.delete
  end
end
