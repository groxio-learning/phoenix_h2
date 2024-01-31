defmodule Fog.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
    # useless children
#      {Fog.Server, %{text: "do or do not, there is no try", steps: 2, name: :yoda}},
#      {Fog.Server, %{text: "So much space for activities", steps: 3, name: :brennan}},
#      {Fog.Server, %{text: "They’re taking the Hobbits to Isengard", steps: 2, name: :legolas}},
#      {Fog.Server, %{text: "I trust him as far as I can throw him", steps: 4, name: :unknown}},
#      {Fog.Server, %{text: "I'll be back", steps: 2, name: :terminator}}
      {DynamicSupervisor, name: :dsup, strategy: :one_for_one}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :rest_for_one, name: Fog.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
