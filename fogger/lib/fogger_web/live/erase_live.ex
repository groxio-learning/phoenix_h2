defmodule FoggerWeb.EraseLive do
  use FoggerWeb, :live_view

  alias Fog.Eraser

  def render(assigns) do
    ~H"""
    <h1>Goodbye world</h1>
    <p><%= Eraser.show(@movie_quote) %></p>
    <button phx-click="erase">Erase me</button>
    <.score_button done={@movie_quote.plan == []} />
    """
  end

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       movie_quote: Eraser.new("Patrze na was glodnych, przerazonych", 4)
     )}
  end

  def handle_event("erase", _, socket) do
    {:noreply, assign(socket, movie_quote: Eraser.erase(socket.assigns.movie_quote))}
  end

  def score_button(assigns) do
    ~H"""
    <button phx-click="score" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 border border-blue-700 rounded">
      <%= if @done, do: "Done", else: "Not done" %>
    </button>
    <%= if @done do %>
      <button phx-click="done">
        Done
      </button>
    <% end %>
    """
  end
end
