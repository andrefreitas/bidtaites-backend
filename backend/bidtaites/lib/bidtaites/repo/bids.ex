defmodule Bidtaites.Repo.Bids do
  use Ecto.Schema

  schema "bids" do
    field :email, :string
    field :price, :integer
    field :photo, :string
    field :title, :string
    field :description, :string
    field :phone_number, :string
  end

  import Ecto.Query
  import Ecto.Changeset
  alias Bidtaites.Repo

  @required_fields ~w(email)

  def all do
    Repo.all(from n in __MODULE__)
  end

  def insert(bid = %{}) do
    %__MODULE__{}
    |> cast(bid, @required_fields)
    |> Repo.insert!
  end

  def get(id) do
    Repo.get!(__MODULE__, id)
  end

  def update(%{id: id} = bid) do
    Repo.get!(__MODULE__, id)
    |> cast(bid, @required_fields)
    |> Repo.update!
  end

  def delete(id) do
    Repo.get!(__MODULE__, id)
    |> Repo.delete!
  end
end
