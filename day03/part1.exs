defmodule Part1 do
  @mul_regex ~r/mul\s*\(\s*([0-9]+)\s*,\s*([0-9]+)\s*\)/

  def extract_mul_results(input_string) do
    @mul_regex
    |> Regex.scan(input_string)
    |> Enum.map(fn [_, x, y] ->
      {num_x, _} = Integer.parse(x)
      {num_y, _} = Integer.parse(y)
      num_x * num_y
    end)
  end

  def solve(filename) do
    filename
    |> File.read!()
    |> extract_mul_results()
    |> Enum.sum()
  end
end

"input.txt"
|> Part1.solve()
|> IO.puts()
