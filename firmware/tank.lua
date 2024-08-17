require "io"
require "rd"


local left_gear = peripheral.wrap("Create_RotationSpeedController_7")
local right_gear = peripheral.wrap("Create_RotationSpeedController_12")
local yaw_gear = peripheral.wrap("Create_RotationSpeedController_9")


local driver = peripheral.find("tweaked_controller")


local max_yaw_speed = 32
local max_speed = 128

local steer_multiplier = 0.5


function resolve_power(analog, buttons) 
	left_gear.setTargetSpeed(clamp((-analog.left.y + (analog.left.x * steer_multiplier)) * max_speed, -max_speed, max_speed))
	right_gear.setTargetSpeed(clamp((-analog.left.y - (analog.left.x * steer_multiplier)) * max_speed, -max_speed, max_speed))
	print("left: " .. textutils.serialize(left_gear.getTargetSpeed()) .. " right: " .. textutils.serialize(right_gear.getTargetSpeed()))
end


function resolve_yaw(analog, buttons)
	yaw_gear.setTargetSpeed(analog.right.x * max_yaw_speed)
end


function set_idle()
	left_gear.setTargetSpeed(0)
	right_gear.setTargetSpeed(0)
	yaw_gear.setTargetSpeed(0)
end


while true do
	if driver.hasUser() then
		local analog = getAnalog(driver)
		local buttons = getButtons(driver)
		resolve_power(analog, buttons)
		resolve_yaw(analog, buttons)
	else set_idle() end
end