function ternary(condition, if_true, if_false)
    if condition then
        return if_true
    else
        return if_false
    end
end

function percentify(v)
    return math.floor(v * 100) .. "%"
end

function clamp(value, min, max)
	if value < min then return min
	elseif value > max then return max
	else return value end
end

function redstone_to_float(value)
    return value / 15.0
end

function redstone_to_axis(value)
    if value == 8 or value == 7
    then
        return 0.0
    else
        return (
            redstone_to_float(value) - 0.5
        ) * 2.0
    end
end

function float_to_redstone(value)
    return math.floor(value * 15.0)
end

function nilcheck(value, message)
    if value == nil
    then
        print("nil check warning: " .. message)
    end
end
