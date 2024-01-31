defmodule FoggerWeb.MovieQuoteLive.FormComponent do
  use FoggerWeb, :live_component

  alias Fogger.Library

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage movie_quote records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="movie_quote-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:text]} type="text" label="Text" />
        <.input field={@form[:steps]} type="number" label="Steps" />
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Movie quote</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{movie_quote: movie_quote} = assigns, socket) do
    changeset = Library.change_movie_quote(movie_quote)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"movie_quote" => movie_quote_params}, socket) do
    changeset =
      socket.assigns.movie_quote
      |> Library.change_movie_quote(movie_quote_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"movie_quote" => movie_quote_params}, socket) do
    save_movie_quote(socket, socket.assigns.action, movie_quote_params)
  end

  defp save_movie_quote(socket, :edit, movie_quote_params) do
    case Library.update_movie_quote(socket.assigns.movie_quote, movie_quote_params) do
      {:ok, movie_quote} ->
        notify_parent({:saved, movie_quote})

        {:noreply,
         socket
         |> put_flash(:info, "Movie quote updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_movie_quote(socket, :new, movie_quote_params) do
    case Library.create_movie_quote(movie_quote_params) do
      {:ok, movie_quote} ->
        notify_parent({:saved, movie_quote})

        {:noreply,
         socket
         |> put_flash(:info, "Movie quote created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
