defmodule Day1 do
  def clean_non_numbers(string), do: string |> String.replace(~r/[^\d]/, "")

  def get_first_and_last_character(string), do: String.first(string) <> String.last(string)

  def solve_puzzle(string) do
    string |> clean_non_numbers |> get_first_and_last_character |> Integer.parse()
  end

  def solve(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(fn a -> solve_puzzle(a) end)
    |> Enum.map(fn
      {value, ""} -> value
    end)
    |> Enum.sum()
    |> IO.puts()
  end
end
