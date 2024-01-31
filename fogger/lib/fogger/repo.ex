defmodule Fogger.Repo do
  use Ecto.Repo,
    otp_app: :fogger,
    adapter: Ecto.Adapters.Postgres
end
