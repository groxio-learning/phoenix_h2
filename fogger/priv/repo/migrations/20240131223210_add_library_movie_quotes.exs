defmodule Fogger.Repo.Migrations.AddLibraryMovieQuotes do
  use Ecto.Migration

  def change do
    create table(:movie_quotes) do
      add :name, :string
      add :text, :string
      add :steps, :integer
      timestamps(type: :utc_datetime)
    end

  end
end
