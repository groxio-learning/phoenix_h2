defmodule Fog.Eraser do
  defstruct text: "some very fun text", plan: []

  def new(text, steps) do
    len = String.length(text)
    chunk_size = ceil(len / steps)

    %__MODULE__{text: text, plan: 1..len |> Enum.shuffle() |> Enum.chunk_every(chunk_size)}
  end

  def erase(%{text: text, plan: [step | plan]}) do
    tuples = text |> String.graphemes |> Enum.with_index(1)
    updated_chars = Enum.map(tuples, fn {ch, i} ->
      cond do
      ch == " " -> ch
      i in step -> "_"
      true -> ch
      end
    end
  )
    %__MODULE__{text: Enum.join(updated_chars), plan: plan}
  end

  def erase(eraser) do
    eraser
  end

  def show(%{text: text}) do
    text
  end
end