defmodule FoggerWeb.ScoreController do
  use FoggerWeb, :controller

  alias Fogger.LeaderBoard
  alias Fogger.LeaderBoard.Score
  alias Fogger.Library

  def index(conn, _params) do
    scores = LeaderBoard.list_scores()
    render(conn, :index, scores: scores)
  end

  def new(conn, params) do
    id =
      if params["id"] do
        params["id"]
      else
        Library.first_movie_quote().id
      end

    changeset = LeaderBoard.change_score(%Score{movie_quote_id: id})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"score" => score_params}) do
    case LeaderBoard.create_score(score_params) do
      {:ok, score} ->
        conn
        |> put_flash(:info, "Score created successfully.")
        |> redirect(to: ~p"/scores/#{score}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    score = LeaderBoard.get_score!(id)
    render(conn, :show, score: score)
  end

  def edit(conn, %{"id" => id}) do
    score = LeaderBoard.get_score!(id)
    changeset = LeaderBoard.change_score(score)
    render(conn, :edit, score: score, changeset: changeset)
  end

  def update(conn, %{"id" => id, "score" => score_params}) do
    score = LeaderBoard.get_score!(id)

    case LeaderBoard.update_score(score, score_params) do
      {:ok, score} ->
        conn
        |> put_flash(:info, "Score updated successfully.")
        |> redirect(to: ~p"/scores/#{score}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, score: score, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    score = LeaderBoard.get_score!(id)
    {:ok, _score} = LeaderBoard.delete_score(score)

    conn
    |> put_flash(:info, "Score deleted successfully.")
    |> redirect(to: ~p"/scores")
  end
end
