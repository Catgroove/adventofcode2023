defmodule Day1 do
  def to_number(""), do: []
  def to_number(<<c>> <> rest) when c in ?1..?9, do: [c - ?0 | to_number(rest)]
  def to_number(<<_>> <> rest), do: to_number(rest)

  def with_string_to_number(""), do: []

  def with_string_to_number(<<c>> <> rest) when c in ?1..?9,
    do: [c - ?0 | with_string_to_number(rest)]

  def with_string_to_number("one" <> rest), do: [1 | with_string_to_number("e" <> rest)]
  def with_string_to_number("two" <> rest), do: [2 | with_string_to_number("o" <> rest)]
  def with_string_to_number("three" <> rest), do: [3 | with_string_to_number("e" <> rest)]
  def with_string_to_number("four" <> rest), do: [4 | with_string_to_number("r" <> rest)]
  def with_string_to_number("five" <> rest), do: [5 | with_string_to_number("e" <> rest)]
  def with_string_to_number("six" <> rest), do: [6 | with_string_to_number("x" <> rest)]
  def with_string_to_number("seven" <> rest), do: [7 | with_string_to_number("n" <> rest)]
  def with_string_to_number("eight" <> rest), do: [8 | with_string_to_number("t" <> rest)]
  def with_string_to_number("nine" <> rest), do: [9 | with_string_to_number("e" <> rest)]
  def with_string_to_number(<<_>> <> rest), do: with_string_to_number(rest)

  def solve_puzzle(file, strategy) do
    file
    |> String.split("\n", trim: true)
    |> Enum.map(strategy)
    |> Enum.map(&(List.first(&1) * 10 + List.last(&1)))
    |> Enum.sum()
  end

  def solve1(file) do
    File.read!(file)
    |> solve_puzzle(&to_number/1)
    |> IO.puts()
  end

  def solve2(file) do
    File.read!(file)
    |> solve_puzzle(&with_string_to_number/1)
    |> IO.puts()
  end
end
