defmodule FoggerWeb.MovieQuoteLive.Index do
  use FoggerWeb, :live_view

  alias Fogger.Library
  alias Fogger.Library.MovieQuote

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :movie_quotes, Library.list_movie_quotes())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Movie quote")
    |> assign(:movie_quote, Library.get_movie_quote!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Movie quote")
    |> assign(:movie_quote, %MovieQuote{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Movie quotes")
    |> assign(:movie_quote, nil)
  end

  @impl true
  def handle_info({FoggerWeb.MovieQuoteLive.FormComponent, {:saved, movie_quote}}, socket) do
    {:noreply, stream_insert(socket, :movie_quotes, movie_quote)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    movie_quote = Library.get_movie_quote!(id)
    {:ok, _} = Library.delete_movie_quote(movie_quote)

    {:noreply, stream_delete(socket, :movie_quotes, movie_quote)}
  end
end
