import Ecto.Query

alias Fogger.LeaderBoard
alias Fogger.Repo

scores = [24, 7, 56, 33, 89, 66, 345, 99]
initials = ~w[bat sxg dev nat jak shy]

quotes = from(m in Fogger.Library.MovieQuote, select: m.id) |> Repo.all()

data =
  for m <- quotes, i <- initials, s <- scores, do: %{points: s, initials: i, movie_quote_id: m}

Enum.each(data, fn d -> LeaderBoard.create_score(d) end)
