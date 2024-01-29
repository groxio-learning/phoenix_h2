defmodule Plusplus.Server do
  use GenServer

  alias Plusplus.Counter

  @impl true
  def init(stack) do
    {:ok, Counter.new(stack)}
  end

  @impl true
  def handle_call(:show, _from, state) do
    {:reply, Counter.show(state), state}
  end

  @impl true
  def handle_cast(:inc, state) do
    {:noreply, Counter.inc(state)}
  end

  @impl true
  def handle_cast(:dec, state) do
    {:noreply, Counter.dec(state)}
  end
end
