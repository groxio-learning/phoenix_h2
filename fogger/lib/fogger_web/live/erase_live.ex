defmodule FoggerWeb.EraseLive do
  use FoggerWeb, :live_view

  alias Fog.Eraser

  def render(assigns) do
    ~H"""
    <h1>Goodbye world</h1>
    <p><%= Eraser.show(@movie_quote) %></p>
    <button phx-click="erase">Erase me</button>
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
end
