defmodule Day1 do
  @regex ~r/(?=(\d)|(one)|(two)|(three)|(four)|(five)|(six)|(seven)|(eight)|(nine))/
  @string_number_map %{
    "1" => 1,
    "2" => 2,
    "3" => 3,
    "4" => 4,
    "5" => 5,
    "6" => 6,
    "7" => 7,
    "8" => 8,
    "9" => 9,
    "one" => 1,
    "two" => 2,
    "three" => 3,
    "four" => 4,
    "five" => 5,
    "six" => 6,
    "seven" => 7,
    "eight" => 8,
    "nine" => 9
  }

  def map_to_numbers(string) do
    Regex.scan(@regex, string)
    |> Enum.flat_map(& &1)
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(fn
      key when is_map_key(@string_number_map, key) -> @string_number_map[key]
      key -> key
    end)
  end

  def solve_puzzle(string) do
    string
    |> Enum.map(fn c ->
      case map_to_numbers(c) do
        [] -> 0
        list -> List.first(list) * 10 + List.last(list)
      end
    end)
    |> Enum.sum()
  end

  def solve(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> solve_puzzle()
    |> IO.puts()
  end
end
