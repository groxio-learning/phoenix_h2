defmodule Fogger.LeaderBoard.Score do
  use Ecto.Schema
  import Ecto.Changeset

  schema "scores" do
    field :points, :integer
    field :initials, :string
    # field :movie_quote, :id
    belongs_to :movie_quote, Fogger.Library.MovieQuote

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(score, attrs) do
    score
    #whitelist
    |> cast(attrs, [:points, :initials, :movie_quote_id])
    |> validate_required([:points, :initials, :movie_quote_id])
  end
end
