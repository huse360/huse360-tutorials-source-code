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
    self.qYaw = Quaternion()
    self.qPitch = Quaternion()
    self.yawAmount = 0.0
    self.pitchAmount = 0.0
    self.angleYaw = 180.0
    self.anglePitch = 0.0
end

function CameraRotation:computeAngles() 
    self.angleYaw = self.angleYaw + self.yawAmount * self.speed * Engine.deltatime
    self.anglePitch = self.anglePitch - self.pitchAmount * self.speed * Engine.deltatime

    self.anglePitch = math.clamp(self.anglePitch, -45, -1)
    -- Log.print("angleYaw: " .. tostring(self.angleYaw))
    -- Log.print("anglePitch: " .. tostring(self.anglePitch))
end

function CameraRotation:computeRotation()
    self.qYaw:fromAngleAxis(self.angleYaw, Vector3.UNIT_Y)
    self.qPitch:fromAngleAxis(self.anglePitch, Vector3.UNIT_X)
    return self.qYaw * self.qPitch
end

function CameraRotation:computePosition()
    local
    position = self:computeRotation() * Vector3.UNIT_Z
    position = position * self.distance
    position = position + self.player.position
    return position
end

function CameraRotation:lookAtPlayer()
    self.camera.target = self.player.position
end

function CameraRotation:onPostUpdate()
    self:computeAngles()
    self.camera.position = self:computePosition()
    self:lookAtPlayer()
end

function CameraRotation:onLook(stickDirection)
    self.yawAmount = stickDirection.x
    self.pitchAmount = stickDirection.z
end

return CameraRotation
