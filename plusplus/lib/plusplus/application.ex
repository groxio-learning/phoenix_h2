defmodule Plusplus.Application do
  @moduledoc """
  Lifecycle module
  """

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker
      {Plusplus.Server, "42"}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Plusplus.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
