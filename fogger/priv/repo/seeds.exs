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
# alias Fogger.Repo

Accounts.register_user(%{email: "yoda1@may4th.com", password: "lukeskywalker"})
Accounts.register_user(%{email: "yoda2@may4th.com", password: "lukeskywalker"})
Accounts.register_user(%{email: "yoda3@may4th.com", password: "lukeskywalker"})
Accounts.register_user(%{email: "yoda4@may4th.com", password: "lukeskywalker"})
