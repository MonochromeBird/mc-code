require "io"
require "rd"

local motor = peripheral.wrap("Create_RotationSpeedController_6")
local steer = peripheral.wrap("Create_RotationSpeedController_5")
local controller = peripheral.find("tweaked_controller")
local redstone = peripheral.find("redstoneIntegrator")


local max_speed = 256
local max_steer = 128


-- TODO: Add support for DPAD / Analog Stick for keyboard users.
function resolvePower(analog, button)
	motor.setTargetSpeed((analog.right.trigger - analog.left.trigger) * max_speed)
end


function resolveSteer(analog, buttons)
	steer.setTargetSpeed(analog.left.x * max_steer)
end


while true do
	if controller.hasUser() then
		local analog = getAnalog(controller)
		local buttons = getAnalog(controller)
		resolvePower(analog, buttons)
		resolveSteer(analog, button)
		if buttons.start then
			break
		end
		os.sleep(0.05)
	else
		motor.setTargetSpeed(0)
		steer.setTargetSpeed(0)
		os.sleep(0.1)
	end
end