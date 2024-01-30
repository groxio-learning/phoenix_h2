defmodule FogTest do
  use ExUnit.Case
  doctest Fog

  test "greets the world" do
    assert Fog.hello() == :world
  end
end
