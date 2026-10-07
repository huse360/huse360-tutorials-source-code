-- PlayerCoordinator.lua

local PlayerCoordinator = {
    -- Editor-exposed properties
    properties = {
        {
            name = "playerMover",
            displayName = "Player Mover",
            type = "PlayerMover"
        },
        {
            name = "cameraRotation",
            displayName = "Camera Rotation",
            type = "CameraRotation"
        }
    }
}

local RelativeMovement = require("Scripts/Camera/RelativeMovement")

function PlayerCoordinator:init()
    local entity = Object(self.scene, self.entity)
    if not self.playerMover then
        Log.error("playerMover not found in " .. entity.name)
        return
    end

    if not self.cameraRotation then
        Log.error("cameraRotation not found in " .. entity.name)
        return
    end

    -- 'self.scene' and 'self.entity' are provided by the engine
    RegisterEngineEvent(self, "onUpdate")
    self.cameraObject = Object(self.scene, self.cameraRotation.entity)
    self.playerObject = Object(self.scene, self.playerMover.entity)
    self.playerDirection = Vector3()
    self.playerRotation = Quaternion()
    self.relativeMovement = RelativeMovement.new()
end

function PlayerCoordinator:onUpdate()
    self.playerMover:onRotate(self.playerRotation)
    self.playerMover:onMove(self.playerDirection)
end

function PlayerCoordinator:move(direction)
    local rotation, movement =
        self.relativeMovement:calculate(
            direction,
            self.playerObject.position,
            self.cameraObject.position
        )

    self.playerRotation = rotation
    self.playerDirection = movement
end

function PlayerCoordinator:jump()
    self.playerMover:onJump()
end

function PlayerCoordinator:look(direction)
    self.cameraRotation:onLook(direction)
end

return PlayerCoordinator
