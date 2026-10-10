local RelativeMovement = {}
RelativeMovement.__index = RelativeMovement

function RelativeMovement.new()
    local self = setmetatable({}, RelativeMovement)
    self.rotation = Quaternion()
    return self
end

function RelativeMovement:calculate(stickDirection, playerPosition, cameraPosition)
    if stickDirection:length() < 0.01 then
        return nil, stickDirection
    end
    return Quaternion.lookRotation(stickDirection), stickDirection
end

return RelativeMovement