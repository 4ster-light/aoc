local function solve(filename)
  local file = io.open(filename, "r")
  if not file then
    error("Could not open file: " .. filename)
  end
  local content = file:read("*all")
  file:close()

  local mul_pattern = "mul%s*%(s*([0-9]+)%s*,%s*([0-9]+)%s*%)";
  local do_pattern = "do%(%)";
  local dont_pattern = "don't%(%)";

  local results = {}
  local enabled = true

  local start = 1
  while start <= #content do
    -- Try to match do() first
    local do_start, do_end = content:find(do_pattern, start)
    if do_start and do_start == start then
      enabled = true
      start = do_end + 1
    else
      -- Try to match don't() next
      local dont_start, dont_end = content:find(dont_pattern, start)
      if dont_start and dont_start == start then
        enabled = false
        start = dont_end + 1
      else
        -- Try to match mul()
        local mul_start, mul_end, x, y = content:find(mul_pattern, start)
        if mul_start and mul_start == start then
          if enabled then
            table.insert(results, tonumber(x) * tonumber(y))
          end
          start = mul_end + 1
        else
          -- If no match, move forward
          start = start + 1
        end
      end
    end
  end

  local total = 0
  for _, val in ipairs(results) do
    total = total + val
  end
  return total
end

print(solve("input.txt"))
