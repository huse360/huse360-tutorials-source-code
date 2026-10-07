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
    self.horzDirection = Vector3(0,0,0)
end

function PlayerMover:onUpdate()
    self.object.position 
      = self.object.position 
      + self.horzDirection 
      * Engine.deltatime
      * self.speed
end

function PlayerMover:onRotate(rotation)
    if not rotation then return end
    self.object.rotation = rotation
end

function PlayerMover:onMove(direction)
  self.horzDirection = direction
end

function PlayerMover:onJump()

end

return PlayerMover
