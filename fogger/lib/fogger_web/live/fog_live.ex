defmodule FoggerWeb.FogLive do
  use FoggerWeb, :live_view

  alias Fogger.Library
  alias Fog.Eraser

  @impl true
  def render(assigns) do
    ~H"""
    <.header>HERE BE MEMORY DRAGONS</.header>
    <div><%=Eraser.show(@movie_quote) %></div>
    <button phx-click="erase" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 border border-blue-700 rounded">
      Erase
    </button>
    <pre><%= inspect(assigns, pretty: true) %></pre>
    """
  end

  #constructor
  @impl true # callbacks and behaviours
  def mount(%{"id" => id}, _session, socket) do
    movie_quote = Library.get_movie_quote!(id)
    {:ok, socket |> assign(movie_quote: Eraser.new(movie_quote.text, movie_quote.steps))}
  end

  @impl true
  def handle_event("erase", _, socket) do
    new_text =
      socket.assigns.movie_quote
      |> Eraser.erase()

    {:noreply, assign(socket, movie_quote: new_text)}
  end

end
