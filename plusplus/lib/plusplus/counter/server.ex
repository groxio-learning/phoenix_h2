defmodule Plusplus.Server do
  @moduledoc """
  - Lets GenServer handle all the "process machinery" (rely on infrastructure)
  - atom modules are erlang modules (e.g. :sys.get_state)
  - recompiling does not kill the process! Hot code reloading
  - see talk: Bryan Hunter (Covid & Elixir) - no db?!, replicated GenServers

  - Lifecycle managers -> supervisors
  - Do Fun Things (w/) Big Louder Worker Bees
    - Data, Functions, Test
    - Boundaries (GenServer - processes, APIs, ect.; code more defensively here (e.g. with, "let it crash"). The 'messy outside world'. Functional core = certainty), Lifecycle (supervisor), Workers
    - since its so uncertain "out there", supervisors are a kind of safeguard
  - property based testing is possible b/c functional core (see book)
  """

  # a macro: use this as service
  # injects code that is considered "process machinery" (not to be modified)
  # we modify the callbacks (@impl true)

  # erlang: need genserver key in emacs to generate this!!
  use GenServer

  alias Plusplus.Counter

  # client API
  # why start_link? "link" state to parent; if p started in link, there's guarantee that client process also crashes - prevent zombie process
  def start_link(input) do
    # start a counter for this module
    {:ok, _pid} = GenServer.start_link(__MODULE__, input, name: :counter)
  end

  # \\ is a lopsided equal sign :D
  def inc(pid \\ :counter) do
    GenServer.cast(pid, :inc)
  end

  def dec(pid \\ :counter) do
    GenServer.cast(pid, :dec)
  end

  # 2 functions in 1 (/1, /0)
  def show(pid \\ :counter) do
    GenServer.call(pid, :show)
  end

  # server callbacks
  # keep this slim as possible, processing/decision making should be outside of init
  @impl true
  def init(input) do
    IO.puts("starting with #{input}")
    {:ok, Counter.new(input)}
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
