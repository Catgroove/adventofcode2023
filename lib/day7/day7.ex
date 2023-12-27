defmodule Day7 do
  def solve(file) do
    File.read!(file)
    |> solve_puzzle()
    |> IO.inspect()
  end

  def solve_puzzle(file) do
    file
    |> String.split("\n", trim: true)
    |> Enum.map(&map_line/1)
    |> Enum.sort_by(&{elem(&1, 0), elem(&1, 1)}, :asc)
    |> Enum.with_index(1)
    |> Enum.map(fn {game, index} -> elem(game, 2) * index end)
    |> Enum.sum()
  end

  def points(hand) do
    hand
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.sort(:desc)
    |> map_hand()
  end

  def map_line(line) do
    [hand | [bid]] = String.split(line, " ")

    hand =
      hand
      |> String.graphemes()
      |> Enum.map(&map_card/1)

    {points(hand), hand, String.to_integer(bid)}
  end

  def map_card(card) do
    case card do
      "A" -> "14"
      "K" -> "13"
      "Q" -> "12"
      "J" -> "11"
      "T" -> "10"
      _ -> card
    end
    |> String.to_integer()
  end

  def map_hand([5]), do: 7
  def map_hand([4, 1]), do: 6
  def map_hand([3, 2]), do: 5
  def map_hand([3, 1, 1]), do: 4
  def map_hand([2, 2, 1]), do: 3
  def map_hand([2, 1, 1, 1]), do: 2
  def map_hand([1, 1, 1, 1, 1]), do: 1
end
