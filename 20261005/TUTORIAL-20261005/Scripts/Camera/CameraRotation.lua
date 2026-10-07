-- CameraRotation.lua

require("Scripts/Extensions/math+clamp")

local CameraRotation = {
    -- Editor-exposed properties
    properties = {
        {
            name = "player",
            displayName = "Player",
            type = "Player"
        }
    }
}

function CameraRotation:init()
    self.camera = Camera(self.scene, self.entity)
    if not self.player then
        Log.error("player not found in " .. self.camera.name)
        return
    end

    Log.print("Camera is " .. self.camera.name)


    -- 'self.scene' and 'self.entity' are provided by the engine
    RegisterEngineEvent(self, "onPostUpdate")

    self.player = Object(self.scene, self.player.entity)   
end

function CameraRotation:onPostUpdate()

end

function CameraRotation:onLook(direction)

end

return CameraRotation
