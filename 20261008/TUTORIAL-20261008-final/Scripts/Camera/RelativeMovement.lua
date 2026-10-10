local RelativeMovement = {}
RelativeMovement.__index = RelativeMovement

function RelativeMovement.new()
    local self = setmetatable({}, RelativeMovement)
    return self
end

function RelativeMovement:calculate(stickDirection, playerPosition, cameraPosition)
    local stickLeght = stickDirection:length()
    if stickLeght < 0.01 then
        return nil, Vector3()
    end

    local forward = playerPosition - cameraPosition
    forward.y = 0

    local rotation
        = Quaternion.lookRotation(stickDirection)
        * Quaternion.lookRotation(forward)

    local movement
        = rotation * Vector3.UNIT_Z * stickLeght
       
    return rotation, movement
end

return RelativeMovement