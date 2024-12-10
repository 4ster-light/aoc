local function parse_line(line)
  local l, r = line:match("(%d+)%s+(%d+)")
  return tonumber(l), tonumber(r)
end

local function calculate_similarity(left, right)
  local right_count = {}

  for _, num in ipairs(right) do
    right_count[num] = (right_count[num] or 0) + 1
  end

  local total = 0
  for _, num in ipairs(left) do
    total = total + num * (right_count[num] or 0)
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

  return calculate_similarity(left, right)
end

print(solve("input.txt"))
