defmodule Plusplus.Counter do
  def new(input) do
    String.to_integer(input)
  end

  def inc(counter) do
    counter + 1
  end

  def dec(counter) do
    counter - 1
  end

  def show(counter) do
    "ants are is #{counter}"
  end
end