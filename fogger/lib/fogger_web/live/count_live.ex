defmodule FoggerWeb.CountLive do
  use FoggerWeb, :live_view

  alias Plusplus.Counter

  @impl true
  def render(assigns) do
    ~H"""
    <.header>HERE BE DRAGONS</.header>
    <button phx-click="inc" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 border border-blue-700 rounded">
      <%=Counter.show(@count) %>
    </button>
    <pre><%= inspect(assigns, pretty: true) %></pre>
    """
  end

  #constructor
  @impl true # callbacks and behaviours
  def mount(_params, _session, socket) do
    counter = Counter.new("7");

    {:ok, socket |> assign(count: counter)}
  end

  def handle_event("inc", _, socket) do
    new_count =
      socket.assigns.count
      |> Counter.inc()

    {:noreply, assign(socket, count: new_count)}
  end

end
