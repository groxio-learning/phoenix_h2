defmodule Plusplus.Service do
  alias Plusplus.Counter

  #client
  def start(input) do
    spawn(fn ->
      input
      |> Counter.new()
      |> loop()
    end)
  end

  def inc(pid) do
    send(pid, :inc)
  end

  def dec(pid) do
    send(pid, :dec)
  end

  def show(pid) do
    send(pid, {:show, self()})
    receive do
      {:show, msg} -> msg
    end
  end

  #server
  def listen(count) do
    receive do
      :inc ->
        Counter.inc(count)
      :dec ->
        Counter.dec(count)
      {:show, from_pid} ->
        send(from_pid, {:show, Counter.show(count)})
        count
    end

  end

  def loop(count) do
    count
    |> listen()
    |> loop()
  end

end
