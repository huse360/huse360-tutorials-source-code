local PlayerWallCollider = {
  -- Editor-exposed properties
  properties = {
    {
      name = "colliderDistance",
      displayName = "Collider Distance",
      type = "float",
      default = 0.4
    }
  }
}

function PlayerWallCollider:init()
  -- 'self.scene' and 'self.entity' are provided by the engine
  RegisterEngineEvent(self, "onUpdate")

  self.object = Object(self.scene, self.entity)
end

function PlayerWallCollider:onUpdate()
  
end

return PlayerWallCollider
