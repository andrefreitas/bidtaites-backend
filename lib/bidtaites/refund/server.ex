defmodule Bidtaites.Refund.Server do
  use GenServer

  require Logger

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: {:global, args[:uuid]})
  end

  def init(args) do
    state = %{
      uuid: args[:uuid],
      end_at: args[:end_at],
      supervisor_pid: args[:supervisor_pid]
    }

    #timeout = state.end_at - (DateTime.utc_now |> DateTime.to_unix)
    timeout = 0
    Logger.info("starting auction: #{args[:uuid]} with timeout #{timeout}")
    Process.send_after(self(), {:timeout}, (if timeout < 0, do: 0, else: (timeout * 1000)))

    {:ok, state}
  end

  def child_spec(args) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [args]},
      restart: :transient,
      type: :worker
    }
  end

  def handle_info({:timeout}, %{uuid: uuid} = state) do
    Logger.info("closing auction: #{uuid}")
    {:ok, _} = Bidtaites.Interactors.CloseAuction.call(uuid, "CLOSED")
    {:stop, {:shutdown, :timeout}, state}
  end
end
