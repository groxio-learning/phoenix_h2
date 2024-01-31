defmodule Fog.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Fog.Server, {"do or do not, there is no try", 2, :yoda}},
      {Fog.Server, {"So much space for activities", 3, :brennan}},
      {Fog.Server, {"They’re taking the Hobbits to Isengard", 2, :legolas}},
      {Fog.Server, {"I trust him as far as I can throw him", 4, :unknown}},
      {Fog.Server, {"I'll be back", 2, :terminator}}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Fog.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
