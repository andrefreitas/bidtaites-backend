defmodule Bidtaites.Refund.DynamicSupervisor do
  use DynamicSupervisor

  alias Bidtaites.Refund.Server

  def start_link(_) do
    DynamicSupervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_child(auction) do
    DynamicSupervisor.start_child(__MODULE__, {Server, auction})
  end
end
