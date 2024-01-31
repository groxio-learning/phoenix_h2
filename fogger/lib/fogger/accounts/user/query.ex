defmodule Fogger.Accounts.User.Query do
  import Ecto.Query
  alias Fogger.Accounts.User

  def new() do
    User
  end

  # query is a Queryable
  def non_admins(query \\ User) do
    from(u in query, where: u.email != "admin@admin.com")
  end

  def recent(query \\ User) do
    one_day_ago = DateTime.add(DateTime.utc_now(), -1, :minute)
    from(u in query, where: u.inserted_at > ^one_day_ago)
  end
end
