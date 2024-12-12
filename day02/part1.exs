defmodule Part1 do
  defp monotonic?(lst) do
    Enum.sort(lst) == lst || Enum.sort(lst, :desc) == lst
  end

  defp valid_differences?(lst) do
    lst
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.all?(fn [a, b] ->
      diff = abs(b - a)
      diff >= 1 && diff <= 3
    end)
  end

  defp safe_report?(report) do
    monotonic?(report) && valid_differences?(report)
  end

  defp parse_reports(input_string) do
    input_string
    |> String.split("\n", trim: true)
    |> Enum.map(fn report_str ->
      report_str
      |> String.split()
      |> Enum.map(&String.to_integer/1)
    end)
  end

  defp count_safe_reports(reports) do
    reports
    |> Enum.filter(&safe_report?/1)
    |> Enum.count()
  end

  def solve(filename) do
    filename
    |> File.read!()
    |> parse_reports()
    |> count_safe_reports()
  end
end

"input.txt"
|> Part1.solve()
|> IO.puts()
