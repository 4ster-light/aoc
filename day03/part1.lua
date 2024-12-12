local function extract_mul_results(input_string)
  local results = {}
  local mul_pattern = "mul%s*%((%s*[0-9]+)%s*,%s*([0-9]+)%s*%)"
  
  for x, y in input_string:gmatch(mul_pattern) do
    local num_x = tonumber(x)
    local num_y = tonumber(y)
    table.insert(results, num_x * num_y)
  end
  
  return results
end

local function sum_mul_results(results)
  local total = 0
  for _, value in ipairs(results) do
    total = total + value
  end
  return total
end

local function solve(filename)
  local file = io.open(filename, "r")
  if not file then
    error("Could not open file: " .. filename)
  end
  
  local input_string = file:read("*all")
  file:close()
  
  local mul_results = extract_mul_results(input_string)
  return sum_mul_results(mul_results)
end

print(solve("input.txt"))
