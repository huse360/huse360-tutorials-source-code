-- math+extension.lua

function math.clamp(value, min, max)
    return math.max(min, math.min(max, value))
end

function math.clamp01(value)
    return math.clamp(value, 0, 1)
end

function math.lerp(a, b, t)
    return (1 - t) * a + t * b
end

function math.lerp01(a, b, t)
    local t01 = math.clamp01(t)
    return (1 - t01) * a + t01 * b
end

return math