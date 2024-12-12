defmodule Part2 do
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

  defp safe_report_with_dampener?(report) do
    # Check if the report is safe without removing any level
    if safe_report?(report) do
      true
    else
      # Try removing each level and check if the resulting list is safe
      Enum.with_index(report)
      |> Enum.any?(fn {_, index} ->
        modified_report = List.delete_at(report, index)
        monotonic?(modified_report) && valid_differences?(modified_report)
      end)
    end
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

  defp count_safe_reports_with_dampener(reports) do
    reports
    |> Enum.filter(&safe_report_with_dampener?/1)
    |> Enum.count()
  end

  def solve(filename) do
    filename
    |> File.read!()
    |> parse_reports()
    |> count_safe_reports_with_dampener()
  end
end

"input.txt"
|> Part2.solve()
|> IO.puts()
