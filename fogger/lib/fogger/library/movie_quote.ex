defmodule Fogger.Library.MovieQuote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "movie_quotes" do
    field(:name, :string)
    field(:text, :string)
    field(:steps, :integer)

    has_many(:scores, Fogger.LeaderBoard.Score)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(movie_quote, attrs) do
    movie_quote
    |> cast(attrs, [:text, :steps, :name])
    |> validate_required([:text, :steps, :name])
  end
end
