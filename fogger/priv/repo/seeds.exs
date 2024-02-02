# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Fogger.Repo.insert!(%Fogger.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Fogger.Accounts
alias Fogger.Library
alias Fogger.LeaderBoard
# alias Fogger.Repo

#Accounts.register_user(%{email: "yoda1@may4th.com", password: "lukeskywalker"})
#Accounts.register_user(%{email: "yoda2@may4th.com", password: "lukeskywalker"})
Accounts.register_user(%{email: "yoda3@may4th.com", password: "lukeskywalker"})
#Accounts.register_user(%{email: "yoda4@may4th.com", password: "lukeskywalker"})

Library.create_movie_quote(%{text: "do or do not, there is no try", steps: 2, name: "yoda"})
Library.create_movie_quote(%{text: "So much space for activities", steps: 3, name: "brennan"})
Library.create_movie_quote(%{text: "They’re taking the Hobbits to Isengard", steps: 2, name: "legolas"})
Library.create_movie_quote(%{text: "I trust him as far as I can throw him", steps: 4, name: "unknown"})
Library.create_movie_quote(%{text: "I'll be back", steps: 2, name: "terminator"})

LeaderBoard.create_score(%{points: 100, initials: "bat", movie_quote_id: 1})
LeaderBoard.create_score(%{points: 22, initials: "nat", movie_quote_id: 4})
LeaderBoard.create_score(%{points: 33, initials: "jac", movie_quote_id: 1})
LeaderBoard.create_score(%{points: 111, initials: "dev", movie_quote_id: 2})
LeaderBoard.create_score(%{points: 8, initials: "sxh", movie_quote_id: 3})
LeaderBoard.create_score(%{points: 9, initials: "shy", movie_quote_id: 3})
