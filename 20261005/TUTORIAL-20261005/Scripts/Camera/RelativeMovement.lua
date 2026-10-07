local RelativeMovement = {}
RelativeMovement.__index = RelativeMovement

function RelativeMovement.new()
    local self = setmetatable({}, RelativeMovement)
    self.rotation = Quaternion()
    return self
end

function RelativeMovement:calculate(direction, playerPosition, cameraPosition)
    return Quaternion(), direction
end

return RelativeMovement