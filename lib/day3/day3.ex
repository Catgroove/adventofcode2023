defmodule Day3 do
  def solve(file) do
    File.read!(file)
    |> solve_puzzle()
    |> IO.inspect()
  end

  def solve_puzzle(file) do
    lines =
      file
      |> String.split("\n")
      |> Enum.with_index()

    symbols =
      lines
      |> Enum.flat_map(fn {line, i} ->
        Regex.scan(~r/[^\d.]/, line, return: :index)
        |> List.flatten()
        |> Enum.map(fn {j, _} -> {i, j} end)
      end)

    lines
    |> Enum.flat_map(fn {line, i} ->
      Regex.scan(~r/\d+/, line, return: :index)
      |> List.flatten()
      |> Enum.map(fn {j, len} ->
        {(i - 1)..(i + 1), (j - 1)..(j + len), String.slice(line, j, len)}
      end)
    end)
    |> Enum.filter(fn {rows, cols, _} ->
      for i <- rows, j <- cols, reduce: false, do: (acc -> acc || {i, j} in symbols)
    end)
    |> Enum.map(&String.to_integer(elem(&1, 2)))
    |> Enum.sum()
  end
end
