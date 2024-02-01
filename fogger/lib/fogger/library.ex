defmodule Fogger.Library do
  @moduledoc """
  The Library context.
  """

  import Ecto.Query, warn: false
  alias Fogger.Repo

  alias Fogger.Library.MovieQuote
  alias Fogger.Library.MovieQuote.Query

  @doc """
  Returns the list of movie_quotes.

  ## Examples

      iex> list_movie_quotes()
      [%MovieQuote{}, ...]

  """
  def list_movie_quotes do
    Repo.all(MovieQuote)
  end

  @doc """
  Gets a single movie_quote.

  Raises `Ecto.NoResultsError` if the Movie quote does not exist.

  ## Examples

      iex> get_movie_quote!(123)
      %MovieQuote{}

      iex> get_movie_quote!(456)
      ** (Ecto.NoResultsError)

  """
  def get_movie_quote!(id), do: Repo.get!(MovieQuote, id)

  @doc """
  Creates a movie_quote.

  ## Examples

      iex> create_movie_quote(%{field: value})
      {:ok, %MovieQuote{}}

      iex> create_movie_quote(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_movie_quote(attrs \\ %{}) do
    %MovieQuote{}
    |> MovieQuote.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a movie_quote.

  ## Examples

      iex> update_movie_quote(movie_quote, %{field: new_value})
      {:ok, %MovieQuote{}}

      iex> update_movie_quote(movie_quote, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_movie_quote(%MovieQuote{} = movie_quote, attrs) do
    movie_quote
    |> MovieQuote.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a movie_quote.

  ## Examples

      iex> delete_movie_quote(movie_quote)
      {:ok, %MovieQuote{}}

      iex> delete_movie_quote(movie_quote)
      {:error, %Ecto.Changeset{}}

  """
  def delete_movie_quote(%MovieQuote{} = movie_quote) do
    Repo.delete(movie_quote)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking movie_quote changes.

  ## Examples

      iex> change_movie_quote(movie_quote)
      %Ecto.Changeset{data: %MovieQuote{}}

  """
  def change_movie_quote(%MovieQuote{} = movie_quote, attrs \\ %{}) do
    MovieQuote.changeset(movie_quote, attrs)
  end


  def next_movie_quote(%MovieQuote{} = movie_quote) do
    #start with a query returning the first quote after passed
    # new |> acs |> next_by_id
    # new |> desc <- prev

    next_quote =
      Query.new() #constructor on top of the pipe
      |> Query.ascending()
      |> Query.next_by_id(movie_quote.id)
      |> Repo.one()

    cond do
      next_quote -> next_quote
      true ->
        Query.new()
        |> Query.ascending()
        |> Repo.one()
    end
  end

  def previous_movie_quote(%MovieQuote{} = movie_quote) do

    previous_quote =
      Query.new()
      |> Query.descending()
      |> Query.prev_by_id(movie_quote.id)
      |> Repo.one()

    # choose first pattern that matches, first truthy
    # could use :otherwise instead
    # cond do
    #   previous_quote -> previous_quote
    #   :otherwise ->
    #     Query.new()
    #     |> Query.descending()
    #     |> Repo.one()
    # end

    # if previous_quote,
    #   do: previous_quote,
    #   else: Query.new()
    #         |> Query.descending()
    #         |> Repo.one()

    # case previous_quote do
    #   nil ->
    #     Query.new()
    #     |> Query.descending()
    #     |> Repo.one()
    #   _ ->
    #     previous_quote
    # end

    case previous_quote do
      %MovieQuote{} -> previous_quote
      _ -> Query.new()
           |> Query.descending()
           |> Repo.one()
    end

  end
end
