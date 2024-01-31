defmodule Plusplus.CounterMap do
  def new(input) do
    %{count: String.to_integer(input)}
  end

  def inc(%{count: count}) do
    %{count: count + 1}
  end

  def dec(%{count: count}) do
    %{count: count - 1}
  end

  def show(%{count: count}) do
    "ants are is #{count}"
  end
end
