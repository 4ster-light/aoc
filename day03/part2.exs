defmodule Part2 do
  @mul_regex ~r/mul\s*\(\s*([0-9]+)\s*,\s*([0-9]+)\s*\)/
  @do_regex ~r/do\(\)/
  @dont_regex ~r/don't\(\)/

  def solve(filename) do
    filename
    |> File.read!()
    |> process_instructions()
    |> Enum.sum()
  end

  defp process_instructions(input) do
    input
    |> String.split(~r/(?=mul|do\(\)|don't\(\))/)
    |> Enum.reduce({true, []}, fn segment, {enabled, results} ->
      cond do
        String.match?(segment, @do_regex) ->
          {true, results}

        String.match?(segment, @dont_regex) ->
          {false, results}

        enabled and String.match?(segment, @mul_regex) ->
          {enabled, [eval_mul(segment) | results]}

        true ->
          {enabled, results}
      end
    end)
    |> elem(1)
  end

  defp eval_mul(instruction) do
    [_, x, y] = Regex.run(@mul_regex, instruction)
    String.to_integer(x) * String.to_integer(y)
  end
end

"input.txt"
|> Part2.solve()
|> IO.puts()
