defmodule Day4 do
  def solve(file) do
    File.read!(file)
    |> solve_puzzle()
    |> IO.inspect()
  end

  def solve_puzzle(file) do
    file
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
    |> Enum.map(&count/1)
    |> List.flatten()
    |> Enum.sum()
  end

  def parse_line("Card " <> line) do
    line
    |> String.split(" | ")
    |> Enum.map(&parse_halves/1)
    |> List.flatten()
    |> Enum.group_by(& &1)
    |> Enum.filter(fn {_, values} -> length(values) > 1 end)
    |> Enum.map(&elem(&1, 0))
  end

  def parse_halves(half) do
    half
    |> String.split(" ")
    |> Enum.filter(&(&1 != "" && !String.contains?(&1, ":")))
    |> Enum.map(&String.to_integer/1)
  end

  def count([]), do: 0
  def count(list), do: 2 ** (length(list) - 1)
end
