local function in_bounds(grid, x, y)
  return x >= 1 and x <= #grid and y >= 1 and y <= #grid[1]
end

local function count(grid)
  local directions = {
    { dx = 1,  dy = 0 },  -- Right
    { dx = -1, dy = 0 },  -- Left
    { dx = 0,  dy = 1 },  -- Down
    { dx = 0,  dy = -1 }, -- Up
    { dx = 1,  dy = 1 },  -- Diagonal down-right
    { dx = -1, dy = -1 }, -- Diagonal up-left
    { dx = 1,  dy = -1 }, -- Diagonal down-left
    { dx = -1, dy = 1 },  -- Diagonal up-right
  }

  local word = "XMAS"
  local word_length = #word
  local word_count = 0

  for x = 1, #grid do
    for y = 1, #grid[1] do
      for _, dir in ipairs(directions) do
        local matches = true
        for i = 0, word_length - 1 do
          local nx, ny = x + i * dir.dx, y + i * dir.dy
          if not in_bounds(grid, nx, ny) or grid[nx]:sub(ny, ny) ~= word:sub(i + 1, i + 1) then
            matches = false
            break
          end
        end
        if matches then
          word_count = word_count + 1
        end
      end
    end
  end

  return word_count
end

local function solve(filename)
  local grid = {}
  for line in io.lines(filename) do
    table.insert(grid, line)
  end
  return count(grid)
end

print(solve("input.txt"))
