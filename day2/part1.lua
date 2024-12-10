local function is_monotonic(lst)
    local ascending = true
    local descending = true
    
    for i = 2, #lst do
        if lst[i] < lst[i-1] then
            ascending = false
        end
        if lst[i] > lst[i-1] then
            descending = false
        end
    end
    
    return ascending or descending
end

local function valid_differences(lst)
    for i = 2, #lst do
        local diff = math.abs(lst[i] - lst[i-1])
        if diff < 1 or diff > 3 then
            return false
        end
    end
    return true
end

local function safe_report(report)
    return is_monotonic(report) and valid_differences(report)
end

local function parse_reports(input_string)
    local reports = {}
    for line in input_string:gmatch("[^\r\n]+") do
        local report = {}
        for num in line:gmatch("%d+") do
            table.insert(report, tonumber(num))
        end
        table.insert(reports, report)
    end
    return reports
end

local function count_safe_reports(reports)
    local count = 0
    for _, report in ipairs(reports) do
        if safe_report(report) then
            count = count + 1
        end
    end
    return count
end

local function solve(filename)
    local file = io.open(filename, "r")
    if not file then return 0 end
    
    local input_string = file:read("*all")
    file:close()
    
    local reports = parse_reports(input_string)
    return count_safe_reports(reports)
end

print(solve("input.txt"))
