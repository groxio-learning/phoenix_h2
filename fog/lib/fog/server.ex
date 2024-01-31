defmodule Fog.Server do
  use GenServer

  alias Fog.Eraser

  # Client
  def start_link(%{text: text, steps: steps, name: name}) do
    IO.puts("process comin up! #{name}")
    GenServer.start_link(__MODULE__, %{text: text, steps: steps}, name: name(name))
  end

  def erase(pid \\ :eraser) do
    GenServer.cast(name(pid), :erase)
  end

  def show(pid \\ :eraser) do
    GenServer.call(name(pid), :show)
  end

  def child_spec(opts) do
    %{
      id: opts.name,
      start: {Fog.Server, :start_link, [opts]}
    }
  end

  # Server (callbacks)
  @impl true
  def init(%{text: text, steps: steps}) do
    initial_state = Eraser.new(text, steps)

    {:ok, initial_state}
  end

  @impl true
  def handle_call(:show, _from, state) do
    {:reply, Eraser.show(state), state}
  end

  @impl true
  def handle_cast(:erase, state) do
    {:noreply, Eraser.erase(state)}
  end

  #via registry
  defp name(name) do
    {:via, Registry, {:lookup, name}}
  end
end
