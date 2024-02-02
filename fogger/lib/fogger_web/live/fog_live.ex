defmodule FoggerWeb.FogLive do
  use FoggerWeb, :live_view

  alias Fogger.Library
  alias Fog.Eraser

  @impl true
  def render(assigns) do
    ~H"""
    <.header>HERE BE MEMORY DRAGONS</.header>
    <div><%=Eraser.show(@eraser) %></div>
    <button phx-click="erase" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 border border-blue-700 rounded">
      Erase
    </button>
    <.score_button done={@eraser.plan == []} />
    <pre><%= inspect(assigns, pretty: true) %></pre>
    """
  end

  # constructor
  # callbacks and behaviours
  @impl true
  def mount(%{"id" => id}, _session, socket) do
    movie_quote = Library.get_movie_quote!(id)

    {:ok,
     socket
     |> assign(
       eraser: Eraser.new(movie_quote.text, movie_quote.steps),
       movie_quote: movie_quote
     )}
  end

  @impl true
  def handle_event("erase", _, socket) do
    new_text =
      socket.assigns.eraser
      |> Eraser.erase()

    {:noreply, assign(socket, eraser: new_text)}
  end

  def handle_event("done", _, socket) do
    {:noreply, push_redirect(socket, to: "/scores/new/#{socket.assigns.movie_quote.id}")}
  end

  def score_button(assigns) do
    ~H"""
    <%= if @done do %>
      <button phx-click="done" class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 border border-green-700 rounded">
        High Score
      </button>
    <% end %>
    """
  end
end
