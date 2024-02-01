defmodule Fogger.Library.MovieQuote.Query do
  import Ecto.Query
  alias Fogger.Repo
  alias Fogger.Library.MovieQuote

  # this one looks funky :(
  def new(quote \\ %MovieQuote{id: 0, text: "something", name: "name"}) do
    quote
  end

  def next(query \\ MovieQuote, quote) do
    count = Repo.aggregate(query, :count)

    if count == quote.id do
      from(m in query, where: m.id == 1)
    else
      from(m in query, where: m.id == ^quote.id + 1)
    end

  end

  def prev(query \\ MovieQuote, quote) do
    count = Repo.aggregate(query, :count)

    if quote.id == 1 do
      from(m in query, where: m.id == ^count)
    else
      from(m in query, where: m.id == ^quote.id - 1)
    end
  end

  def count(query \\ MovieQuote) do
    Repo.aggregate(query, :count)
  end

end


