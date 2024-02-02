defmodule Fogger.Repo.Migrations.CreateScores do
  use Ecto.Migration

  def change do
    create table(:scores) do
      add(:points, :integer)
      add(:initials, :string)
      add(:movie_quote_id, references(:movie_quotes, on_delete: :nothing))

      timestamps(type: :utc_datetime)
    end

    create(index(:scores, [:movie_quote_id]))
    create(index(:scores, [:id]))
  end
end
