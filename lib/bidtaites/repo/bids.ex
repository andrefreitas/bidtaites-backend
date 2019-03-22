defmodule Bidtaites.Repo.Bids do
  use Ecto.Schema

  @derive {Jason.Encoder, except: [:__meta__]}
  schema "bids" do
    field :auction_id, :string
    field :order_id, :string
    field :value, :integer
    field :paid, :integer
    field :email, :string
    field :status, :string

    timestamps()
  end

  @permitted_fields [:auction_id, :order_id, :value, :paid, :email, :status]

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
    |> cast(bid, @permitted_fields)
    |> Repo.insert
  end

  def get_by_order_id(id) do
    Repo.get_by(__MODULE__, order_id: id)
  end

  def update(%{order_id: id} = bid) do
    get_by_order_id(id)
    |> cast(bid, @permitted_fields)
    |> Repo.update()
  end

  def last(id, email) do
    last_bid_query = from b in __MODULE__,
      where: b.auction_id == ^id  and b.email == ^email,
      order_by: [desc: b.value]

    Repo.all(last_bid_query) |> List.first
  end

  def get(email) do
    __MODULE__
    |> where(email: ^email)
    |> Repo.all
  end
end
