defmodule Fogger.Library.MovieQuote.Query do
  import Ecto.Query
  alias Fogger.Repo
  alias Fogger.Library.MovieQuote


  # this one looks funky :(
  # def new(movie_quote \\ %MovieQuote{id: 0, text: "something", name: "name"}) do
  #   movie_quote
  # end

  # should be something that's queryable <--
  def new() do
    from m in MovieQuote, []
  end

  def ascending(q) do
    from m in q, order_by: [asc: :id],  limit: 1
  end

  def descending(q) do
    from m in q, order_by: [desc: :id],  limit: 1
  end

  def next_by_id(query \\ MovieQuote, id) do
    from(m in query, where: m.id > ^id)
  end

  def prev_by_id(query \\ MovieQuote, id) do
    from(m in query, where: m.id < ^id)
  end

  # this can break, so should be in library = boundary layer
  # could force client to specify count, one idea
  def next(query \\ MovieQuote, movie_quote) do
    count = Repo.aggregate(query, :count)

    if count == movie_quote.id do
      from(m in query, where: m.id == 1)
    else
      from(m in query, where: m.id == ^movie_quote.id + 1)
    end

  end

  def prev(query \\ MovieQuote, movie_quote) do
    # not cool to call Repo
    # don't need to aggregate
    # implicit breakage
    count = Repo.aggregate(query, :count)

    # if else would be fine if we had the count
    if movie_quote.id == 1 do
      from(m in query, where: m.id == ^count)
    else
      from(m in query, where: m.id == ^movie_quote.id - 1)
    end
  end

  def count(query \\ MovieQuote) do
    Repo.aggregate(query, :count)
  end

end
