defmodule Fibonacci.Fib do
  def new() do
   {0, 1}
  end

  def next({first, second}) do
    {second, first + second}
  end

  def show({_first, second}) do
    second
  end
end
