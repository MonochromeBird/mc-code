local Energy = {
    max_energy = 100.0,
    
    tickRate = 20
    decay_per_usage = 0.1,

    energy = 100.0,
    usage = 0,
}

local redstone_integrators = {}

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

function Energy:findRedstoneIntegrators()
    redstone_integrators = {}

    for _, name in ipairs(peripheral.getNames()) do
        if string.find(name, "redstoneIntegrator") and redstone_integrators[name] == nil then
            redstone_integrators[name] = peripheral.wrap(name)
        end
    end
end

function Energy:updateUsage()
    calc_usage = 0

    for _, device in ipairs(redstone_integrators) do
        if getIntegratorInput(device) then
            calc_usage = calc_usage + 1
        end
    end

    self.usage = calc_usage
end

function Energy:tick()
    updateUsage()

    self.energy = self.energy - (self.usage * self.decayPerUsage)
    
    print("Energy: " .. self.energy .. " | Usage: " .. self.usage)

    for k, device in ipairs(redstone_integrators) do
        setIntegratorOutput(device, false)
    end
end

function Energy:start()
    while true do
        self:tick()
        os.sleep(1.0 / self.tickRate)
    end
end

Energy:start()