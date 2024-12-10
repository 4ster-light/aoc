defmodule Part1 do
  def solve(filename) do
    filename
    |> File.stream!()
    |> Stream.map(&parse_line/1)
    |> Enum.to_list()
    |> then(fn parsed_lines ->
      left = Enum.map(parsed_lines, &elem(&1, 0))
      right = Enum.map(parsed_lines, &elem(&1, 1))
      calculate_total_distance(left, right)
    end)
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split("   ")
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  defp calculate_total_distance(left, right) do
    left = Enum.sort(left)
    right = Enum.sort(right)

    left
    |> Enum.zip(right)
    |> Enum.map(fn {l, r} -> abs(l - r) end)
    |> Enum.sum()
  end
end

"input.txt"
|> Part1.solve()
|> IO.puts()
