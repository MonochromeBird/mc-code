require "io"

local propellers = {
    back_right = peripheral.wrap(
        "Create_RotationSpeedController_14"),

    front_right = peripheral.wrap(
        "Create_RotationSpeedController_15"),

    back_left = peripheral.wrap(
        "Create_RotationSpeedController_16"),

    front_left = peripheral.wrap(
        "Create_RotationSpeedController_17"),
}

local controller = peripheral.find("tweaked_controller")

-- Local

-- Ranges from -1 to 1 --
local balance_x = 0.0
local balance_y = 0.0
local power_input = 0.0
-------------------------

-- Stress management --
local max_power = (8192 * motors_per_side) / propellers_per_motor
local propellers_per_motor = 2
local motors_per_side = 1
-----------------------

function getPowerInput()
    
end

function updateTargetSpeed(propeller, x, y)
    multiplier =
        math.abs(x - balance_x) *
        math.abs(y - balance_y)

    propeller.setTargetSpeed(power_input * multiplier * max_power)
end

function updateTargetSpeeds()
    updateTargetSpeed(
        propellers.back_right,
        1.0, -1.0
    )

    updateTargetSpeed(
        propellers.back_left,
        -1.0, -1.0
    )

    updateTargetSpeed(
        propellers.front_right,
        1.0, 1.0
    )

    updateTargetSpeed(
        propellers.front_left,
        -1.0, 1.0
    )
end

while true do
    if controller.hasUser() then 

    else
        balance_x = 0
        balance_y = 0
        power_input = 
    end
end

updateTargetSpeeds()

