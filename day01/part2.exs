defmodule Part2 do
  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split("   ")
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  defp calculate_similarity(left, right) do
    right_count = Enum.frequencies(right)

    left
    |> Enum.map(fn num -> num * Map.get(right_count, num, 0) end)
    |> Enum.sum()
  end

  def solve(filename) do
    filename
    |> File.stream!()
    |> Stream.map(&parse_line/1)
    |> Enum.to_list()
    |> then(fn parsed_lines ->
      left = Enum.map(parsed_lines, &elem(&1, 0))
      right = Enum.map(parsed_lines, &elem(&1, 1))
      calculate_similarity(left, right)
    end)
  end
end

"input.txt"
|> Part2.solve()
|> IO.puts()
