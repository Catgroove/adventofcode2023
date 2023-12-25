defmodule Day5 do
  def solve(file) do
    File.read!(file)
    |> solve_puzzle()
    |> IO.inspect()
  end

  def find_number(_current, start, stop, dest, range, search) when search > stop, do: search
  def find_number(current, start, stop, dest, range, search) when search < current, do: search
  def find_number(current, start, stop, dest, range, search) when current == stop, do: search

  def find_number(current, start, stop, dest, range, search) when current == search,
    do: current - start + dest

  def find_number(current, start, stop, dest, range, search) when current != search,
    do: find_number(current + 1, start, stop, dest, range, search)

  def solve_puzzle(file) do
    # source = 3_642_212_803
    # dest = 1_631_134_559
    # range = 163_560_083
    #
    # find_number(source, source + range, 3_742_212_803, dest)

    [seeds | maps] = String.split(file, "\n\n") |> Enum.map(&parse_string_line/1)

    maps =
      maps
      |> Enum.map(fn nums ->
        Enum.map(nums, fn n ->
          List.to_tuple(n)
        end)
        |> List.flatten()
      end)

    seeds
    |> List.flatten()
    |> Enum.map(&map_to_map_values(maps, &1))
    |> IO.inspect()
    |> Enum.min()
  end

  def map_to_map_values([], val), do: val

  def map_to_map_values([map | maps], val) do
    IO.inspect(map, label: "map")
    IO.inspect(val, label: "map")

    map_to_map_values(maps, find_number_in_map(map, val))
  end

  def find_number_in_map([], val), do: val

  def find_number_in_map([{dest, source, range} | map], val) do
    number = find_number(source, source, source + range, dest, range, val)

    IO.inspect({dest, source, range}, label: "tuple")
    IO.inspect(number, label: "number")
    IO.inspect(val, label: "val")

    cond do
      number == val -> find_number_in_map(map, val)
      true -> number
    end
  end

  def parse_string_line(line) do
    [_, numbers] =
      line
      |> String.split(~r/[\w\-\s]+:[\n\s]+/)
      |> Enum.map(&parse_line/1)

    numbers
  end

  def parse_line(line) do
    line
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&parse_numbers/1)
  end

  def parse_numbers(numbers) do
    numbers
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
  end
end
