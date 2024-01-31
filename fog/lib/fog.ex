defmodule Fog do
  alias Fog.Server

  def show(name) do
    Server.show(name)
  end

  def erase(name) do
    Server.erase(name)
  end

  def new(%{name: name, text: text, steps: steps}) do
    DynamicSupervisor.start_child(:dsup, {Fog.Server, %{name: name, text: text, steps: steps}})
  end
end
