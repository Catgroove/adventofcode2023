defmodule Day2 do
  def solve(file) do
    File.read!(file)
    |> solve_puzzle()
    |> IO.inspect()
  end

  def solve_puzzle(file) do
    file
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_game/1)
    |> Enum.filter(fn {_, result} -> Enum.all?(result, &valid_game?/1) end)
    |> Enum.map(fn {game, _} -> game end)
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

  def valid_game?({count, "red"}), do: count <= 12
  def valid_game?({count, "green"}), do: count <= 13
  def valid_game?({count, "blue"}), do: count <= 14
end
