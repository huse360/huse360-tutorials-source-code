-- math+clamp.lua

function math.clamp(value, min, max)
    return math.max(min, math.min(max, value))
end

function math.clamp01(value)
    return math.clamp(value, 0, 1)
end

return math