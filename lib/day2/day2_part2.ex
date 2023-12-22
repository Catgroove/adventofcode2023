defmodule Day2Part2 do
  def solve(file) do
    File.read!(file)
    |> solve_puzzle()
    |> IO.inspect()
  end

  def solve_puzzle(file) do
    file
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_game/1)
    |> Enum.map(fn {_, nums} -> Enum.product(nums) end)
    |> Enum.sum()
  end

  def parse_game("Game " <> game) do
    {id, result} = Integer.parse(game)
    <<": ">> <> result = result

    result =
      result
      |> String.split(";")
      |> Enum.map(&String.trim/1)
      |> Enum.map(&parse_result/1)
      |> Enum.flat_map(& &1)
      |> Enum.sort(fn {a, _}, {b, _} -> a > b end)
      |> Enum.group_by(fn {_, color} -> color end)
      |> Enum.map(fn {_, tuples} -> elem(Enum.at(tuples, 0), 0) end)

    {id, result}
  end

  def parse_result(result) do
    result
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&parse_color/1)
  end

  def parse_color(color) do
    color
    |> String.split(" ")
    |> to_tuple()
  end

  def to_tuple([int_str, color]), do: {String.to_integer(int_str), color}
end
