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

local function safe_report_with_dampener(report)
    -- Check if the report is safe without removing any level
    if safe_report(report) then
        return true
    end
    
    -- Try removing each level and check if the resulting list is safe
    for i = 1, #report do
        local modified_report = {}
        for j = 1, #report do
            if j ~= i then
                table.insert(modified_report, report[j])
            end
        end
        
        if safe_report(modified_report) then
            return true
        end
    end
    
    return false
end

local function count_safe_reports_with_dampener(reports)
    local count = 0
    for _, report in ipairs(reports) do
        if safe_report_with_dampener(report) then
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
    return count_safe_reports_with_dampener(reports)
end

print(solve("input.txt"))
