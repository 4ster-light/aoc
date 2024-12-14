defmodule Part1 do
  @word "XMAS"
  @directions [
    {1, 0},   # Right
    {-1, 0},  # Left
    {0, 1},   # Down
    {0, -1},  # Up
    {1, 1},   # Diagonal down-right
    {-1, -1}, # Diagonal up-left
    {1, -1},  # Diagonal down-left
    {-1, 1}   # Diagonal up-right
  ]

  defp count_matches(grid) do
    Enum.reduce(0..(length(grid) - 1), 0, fn x, acc ->
      Enum.reduce(0..(String.length(Enum.at(grid, x)) - 1), acc, fn y, acc2 ->
        acc2 + count_word(grid, x, y)
      end)
    end)
  end

  defp count_word(grid, x, y) do
    Enum.reduce(@directions, 0, fn {dx, dy}, acc ->
      if word_matches?(grid, x, y, dx, dy), do: acc + 1, else: acc
    end)
  end

  defp word_matches?(grid, x, y, dx, dy) do
    @word
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.all?(fn {char, i} ->
      nx = x + i * dx
      ny = y + i * dy
      in_bounds?(grid, nx, ny) and String.at(Enum.at(grid, nx), ny) == char
    end)
  end

  defp in_bounds?(grid, x, y) do
    x >= 0 and x < length(grid) and y >= 0 and y < String.length(Enum.at(grid, x))
  end

  def solve(filename) do
    filename
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    |> count_matches()
  end
end

"input.txt"
|> Part1.solve()
|> IO.puts()
