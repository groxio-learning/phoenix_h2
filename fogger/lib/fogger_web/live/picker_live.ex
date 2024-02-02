defmodule FoggerWeb.PickerLive do
  use FoggerWeb, :live_view

  alias Fogger.Library

  def render(assigns) do
    ~H"""
    <.header>Picker</.header>
    <div><%= @movie_quote.text %></div>
    <button phx-click="next" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 border border-blue-700 rounded">
      Next
    </button>
    <button phx-click="choose" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 border border-blue-700 rounded">
      Choose
    </button>
    <button phx-click="previous" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 border border-blue-700 rounded">
      Previous
    </button>
    <pre><%= inspect(assigns, pretty: true) %></pre>
    """
  end

  # with id
  def mount(%{"id" => id}, _session, socket) do
    movie_quote = Library.get_movie_quote!(id)
    {:ok, assign(socket, movie_quote: movie_quote)}
  end

  # we wanna redirect
  # push redirect on server
  # patch to stay on the same live view
  def mount(_params, _session, socket) do
    movie_quote = Library.first_movie_quote()
    {:ok, socket |> push_redirect(to: "/choose/#{movie_quote.id}")}
  end

  def handle_event("next", _, socket) do
    new_movie_quote = Library.next_movie_quote(socket.assigns.movie_quote)
    {:noreply, socket |> push_redirect(to: "/choose/#{new_movie_quote.id}")}
  end

  def handle_event("previous", _, socket) do
    prev_movie_quote = Library.previous_movie_quote(socket.assigns.movie_quote)
    {:noreply, socket |> push_redirect(to: "/choose/#{prev_movie_quote.id}")}
  end

  def handle_event("choose", _, socket) do
    movie_quote = socket.assigns.movie_quote
    {:noreply, socket |> push_redirect(to: "/fogger/#{movie_quote.id}")}
  end


end
