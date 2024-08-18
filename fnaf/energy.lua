local Energy = {
    energy = 100,
    decayPerUsage = 0.1,
    usage = 0,

    tickRate = 20
}


local redstoneInterfaces = {}

local sides = {"front", "back", "top", "bottom", "left", "right"}

function setIntegratorOutput(integrator, value)
    for _, side in ipairs(sides) do
        integrator.setOutput(side, value)
    end
end

function getIntegratorInput(integrator)
    for _, side in ipairs(sides) do
        if integrator.getInput(side) then
            return true
        end
    end

    return false
end


function Energy:start()
    
end


function Energy:updateRedstoneInterfaces()
    for _, deviceName in ipairs(peripheral.getNames()) do
        if string.find(deviceName, "redstoneIntegrator") and redstoneInterfaces[deviceName] == nil then
            redstoneInterfaces[deviceName] = peripheral.wrap(deviceName)
        end
    end
end

function Energy:updateUsage()
    calc_usage = 0

    for _, device in ipairs(redstoneInterfaces) do
        if getIntegratorInput(device) then
            calc_usage = calc_usage + 1
        end
    end

    self.usage = calc_usage
end

function Energy:tick()
    self.energy = self.energy - (self.usage * self.decayPerUsage)
    
    if energy <= 0 then
        for k, device in ipairs(redstoneInterfaces) do
            setIntegratorOutput(device, false)
        end
    end
end
