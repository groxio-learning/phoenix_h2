defmodule FoggerWeb.CountLive do
  use FoggerWeb, :live_view

  # from path dep!
  alias Plusplus.Counter

  @impl true
  def render(assigns) do
    ~H"""
    <h1>Hello world!!</h1>
    <button phx-click="inc" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 border border-blue-700 rounded">
      <%= Counter.show(@count) %>
    </button>
    <pre>
      <%= inspect(assigns, pretty: true) %>
    </pre>
    """
  end

  @doc """
  constructor
  """
  @impl true
  def mount(_params, _session, socket) do
    counter = Counter.new("7")

    {:ok, socket |> assign(count: counter)}
  end

  @impl true
  def handle_event("inc", _, socket) do
    new_count =
      socket.assigns.count
      |> Counter.inc()

    {:noreply, assign(socket, count: new_count)}
  end

  # build a new route
  # EraseLive - setup eraser
  # hardcode input
end
