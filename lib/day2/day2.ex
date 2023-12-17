defmodule Day2 do
  def valid_game?({count, "red"}), do: count <= 12
  def valid_game?({count, "green"}), do: count <= 13
  def valid_game?({count, "blue"}), do: count <= 14

  def create_game_key(string),
    do: with([_, id] <- String.split(string, " "), do: String.to_integer(id))

  def create_result(string) do
    string
    |> String.split(";")
    |> Enum.map(fn s ->
      String.split(s, ",")
      |> Enum.map(fn s ->
        s
        |> String.trim()
        |> String.split(" ")
        |> to_tuple()
      end)
    end)
    |> Enum.flat_map(& &1)
  end

  def to_tuple([int_str, color]), do: {String.to_integer(int_str), color}

  def solve_puzzle(file) do
    file
    |> String.split("\n", trim: true)
    |> Enum.map(fn game ->
      with [game, result] <- String.split(game, ":"),
           do: {create_game_key(game), create_result(result)}
    end)
    |> Enum.filter(fn {_, result} -> Enum.all?(result, &valid_game?/1) end)
    |> Enum.map(fn {game, _} -> game end)
    |> Enum.sum()
  end

  def solve(file) do
    File.read!(file)
    |> solve_puzzle()
    |> IO.inspect()
  end
end
