defmodule Fog do
  alias Fog.Server

  def show(name) do
    Server.show(name)
  end

  def erase(name) do
    Server.erase(name)
  end
end
