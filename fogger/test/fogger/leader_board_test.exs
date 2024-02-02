defmodule Fogger.LeaderBoardTest do
  use Fogger.DataCase

  alias Fogger.LeaderBoard

  describe "scores" do
    alias Fogger.LeaderBoard.Score

    import Fogger.LeaderBoardFixtures

    @invalid_attrs %{points: nil, initials: nil}

    test "list_scores/0 returns all scores" do
      score = score_fixture()
      assert LeaderBoard.list_scores() == [score]
    end

    test "get_score!/1 returns the score with given id" do
      score = score_fixture()
      assert LeaderBoard.get_score!(score.id) == score
    end

    test "create_score/1 with valid data creates a score" do
      valid_attrs = %{points: 42, initials: "some initials"}

      assert {:ok, %Score{} = score} = LeaderBoard.create_score(valid_attrs)
      assert score.points == 42
      assert score.initials == "some initials"
    end

    test "create_score/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = LeaderBoard.create_score(@invalid_attrs)
    end

    test "update_score/2 with valid data updates the score" do
      score = score_fixture()
      update_attrs = %{points: 43, initials: "some updated initials"}

      assert {:ok, %Score{} = score} = LeaderBoard.update_score(score, update_attrs)
      assert score.points == 43
      assert score.initials == "some updated initials"
    end

    test "update_score/2 with invalid data returns error changeset" do
      score = score_fixture()
      assert {:error, %Ecto.Changeset{}} = LeaderBoard.update_score(score, @invalid_attrs)
      assert score == LeaderBoard.get_score!(score.id)
    end

    test "delete_score/1 deletes the score" do
      score = score_fixture()
      assert {:ok, %Score{}} = LeaderBoard.delete_score(score)
      assert_raise Ecto.NoResultsError, fn -> LeaderBoard.get_score!(score.id) end
    end

    test "change_score/1 returns a score changeset" do
      score = score_fixture()
      assert %Ecto.Changeset{} = LeaderBoard.change_score(score)
    end
  end
end
