local RelativeMovement = {}
RelativeMovement.__index = RelativeMovement

function RelativeMovement.new()
    local self = setmetatable({}, RelativeMovement)
    self.rotation = Quaternion()
    return self
end

function RelativeMovement:calculate(direction, playerPosition, cameraPosition)
    if direction:length() < 0.1 then
        return nil, direction
    end
    return Quaternion.lookRotation(direction), direction
end

return RelativeMovement