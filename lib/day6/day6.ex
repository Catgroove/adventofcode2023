defmodule Day6 do
  def solve(file) do
    File.read!(file)
    |> solve_puzzle()
    |> IO.inspect()
  end

  def solve_puzzle(file) do
    file
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      Regex.scan(~r/\d+/, line)
      |> List.flatten()
      |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.zip()
    |> Enum.map(&beat_record/1)
    |> Enum.product()
  end

  def beat_record({time, distance}) do
    Enum.map(0..time, &(&1 * (time - &1)))
    |> Enum.filter(&(&1 > distance))
    |> Enum.count()
  end
end
