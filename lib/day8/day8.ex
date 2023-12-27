defmodule Day8 do
  def solve(file) do
    File.read!(file)
    |> solve_puzzle()
    |> IO.inspect()
  end

  def solve_puzzle(file) do
    [instructions, nodes] =
      file
      |> String.split("\n\n")

    nodes =
      nodes
      |> String.split("\n", trim: true)
      |> Enum.map(&map_node/1)
      |> Enum.reduce(%{}, &Map.merge/2)

    traverse(map_instructions(instructions), nodes)
  end

  def traverse(instructions, nodes, value \\ "AAA", acc \\ [], count \\ 0)

  def traverse(_, _, "ZZZ", _, count), do: count

  def traverse([], nodes, value, acc, count),
    do: traverse(Enum.reverse(acc), nodes, value, [], count)

  def traverse([instruction | instructions], nodes, value, acc, count),
    do: traverse(instructions, nodes, nodes[value][instruction], [instruction | acc], count + 1)

  def map_instructions(instructions) do
    instructions
    |> String.graphemes()
    |> Enum.map(fn lr ->
      case lr do
        "R" -> :right
        "L" -> :left
      end
    end)
  end

  def map_node(node) do
    [head, lr] =
      node
      |> String.split(" = ")

    lr =
      lr
      |> String.trim_leading("(")
      |> String.trim_trailing(")")
      |> String.split(", ")
      |> map_lr()

    %{head => lr}
  end

  def map_lr([left, right]), do: %{:left => left, :right => right}
end
