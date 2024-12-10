local function parse_line(line)
  local l, r = line:match("(%d+)%s+(%d+)")
  return tonumber(l), tonumber(r)
end

local function calculate_total_distance(left, right)
  table.sort(left)
  table.sort(right)

  local total = 0
  for i = 1, #left do
    total = total + math.abs(left[i] - right[i])
  end

  return total
end

local function solve(filename)
  local left = {}
  local right = {}

  for line in io.lines(filename) do
    local l, r = parse_line(line)
    table.insert(left, l)
    table.insert(right, r)
  end

  return calculate_total_distance(left, right)
end

print(solve("input.txt"))
