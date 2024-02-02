defmodule Fogger.LeaderBoardFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Fogger.LeaderBoard` context.
  """

  @doc """
  Generate a score.
  """
  def score_fixture(attrs \\ %{}) do
    {:ok, score} =
      attrs
      |> Enum.into(%{
        initials: "some initials",
        points: 42
      })
      |> Fogger.LeaderBoard.create_score()

    score
  end
end
