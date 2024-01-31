defmodule PlusplusTest do
  use ExUnit.Case
  doctest Plusplus

  test "greets the world" do
    assert Plusplus.hello() == :world
  end
end
