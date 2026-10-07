-- PlayerMover.lua

local PlayerMover = {
    -- Editor-exposed properties
    properties = {
        {
            name = "speed",
            displayName = "Speed",
            type = "float",
            default = 6
        }
    }
}

function PlayerMover:init()
    -- 'self.scene' and 'self.entity' are provided by the engine
    RegisterEngineEvent(self, "onUpdate")

    self.object = Object(self.scene, self.entity)

end

function PlayerMover:onUpdate()

end

function PlayerMover:onRotate(rotation)

end

function PlayerMover:onMove(direction)

end

function PlayerMover:onJump()

end

return PlayerMover
