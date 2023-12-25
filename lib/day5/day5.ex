defmodule Day5 do
  def solve(file) do
    File.read!(file)
    |> solve_puzzle()
    |> IO.inspect()
  end

  def solve_puzzle(file) do
    [seeds | maps] =
      file
      |> String.split("\n\n")

    seeds =
      seeds
      |> String.trim_leading("seeds: ")
      |> String.split(" ")
      |> Enum.map(&String.to_integer(&1))

    maps =
      maps
      |> Enum.map(&parse_map/1)

    seeds
    |> Enum.map(&map_seed(&1, maps))
    |> Enum.min()
  end

  def map_seed(seed, maps) do
    maps
    |> Enum.reduce(seed, fn map, seed_value ->
      Enum.find_value(map, seed_value, fn {destination_start.._, source_range = source_start.._} ->
        if seed_value in source_range, do: destination_start + seed_value - source_start
      end)
    end)
  end

  def parse_map(map) do
    [_ | values] =
      map
      |> String.split("\n")
      |> Enum.reject(&(&1 == ""))

    values |> Enum.map(&parse_map_values/1)
  end

  def parse_map_values(map) do
    [destination, source, range] =
      map
      |> String.split(" ")
      |> Enum.map(&String.to_integer(&1))

    {destination..(destination + range), source..(source + range)}
  end
end
