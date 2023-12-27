defmodule Day9 do
  def solve(file) do
    File.read!(file)
    |> solve_puzzle()
    |> IO.inspect()
  end

  def solve_puzzle(file) do
    file
    |> String.split("\n", trim: true)
    |> Enum.map(&map_line/1)
    |> Enum.sum()
  end

  def map_line(line) do
    line =
      line
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)

    [[line], get_diffs(line)]
    |> Enum.flat_map(& &1)
    |> Enum.map(&List.last(&1))
    |> Enum.sum()
  end

  def get_diffs(line, acc \\ []) do
    diffs = diffs(line)

    cond do
      Enum.all?(diffs, &(&1 == 0)) -> [diffs | acc]
      true -> get_diffs(diffs, [diffs | acc])
    end
  end

  def diffs([_]), do: []

  def diffs([n1, n2 | rest]) do
    [n2 - n1 | diffs([n2 | rest])]
  end
end
