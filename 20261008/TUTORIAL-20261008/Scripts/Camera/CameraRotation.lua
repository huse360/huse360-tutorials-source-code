-- CameraRotation.lua

require("Scripts/Extensions/math+extension")

local CameraRotation = {
    -- Editor-exposed properties
    properties = {
        {
            name = "speed",
            displayName = "Rotation Speed",
            type = "float",
            default = 5.0
        },
        {
            name = "distance",
            displayName = "distance",
            type = "float",
            default = 10.0
        },
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
    self.camera.target = self.player.position
end

function CameraRotation:onLook(direction)

end

return CameraRotation
