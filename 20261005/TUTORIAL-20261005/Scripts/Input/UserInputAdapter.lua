-- UserInputAdapter.lua

local UserInputAdapter = {
    -- Editor-exposed properties
    properties = {
        {
            name = "playerCoordinator",
            displayName = "Player Coordinator",
            type = "PlayerCoordinator"
        }
    }
}

function UserInputAdapter:init()
    local entity = Object(self.scene, self.entity)
    if not self.playerCoordinator then
        Log.error("playerCoordinator not found in " .. entity.name)
        return
    end

    -- 'self.scene' and 'self.entity' are provided by the engine
    RegisterEngineEvent(self, "onUpdate")
    self.move = Vector3(0,0,0)
    self.look = Vector2(0,0)

    if Input.numGamepads() > 0 then
        self.gamepad = Input.getGamepadId(0)
    end

    self.buttons = 0
    self.lastButtons = 0
end

function UserInputAdapter:didPressButtonJump()
    return
      Input.isGamepadButtonPressed(self.gamepad, Input.GAMEPAD_BUTTON_A)
      or Input.isKeyPressed(Input.KEY_SPACE)
end

function UserInputAdapter:onUpdate()
    self:getGamepadMovement()
    self:getArrowKeysMovement()
    self.playerCoordinator:move(self.move)
    self.playerCoordinator:look(self.look)

    self.buttons = 0
    if self:didPressButtonJump() then
        self.buttons = 1
    end
    if self.lastButtons == 0 and self.buttons == 1 then
        self.playerCoordinator:jump()
    end
    self.lastButtons = self.buttons
end

function UserInputAdapter:getGamepadMovement()
    if not self.gamepad then return end

    self.move.x = -Input.getGamepadAxis(self.gamepad, Input.GAMEPAD_AXIS_LEFT_X)
    self.move.z = -Input.getGamepadAxis(self.gamepad, Input.GAMEPAD_AXIS_LEFT_Y)

    self.look.x = -Input.getGamepadAxis(self.gamepad, Input.GAMEPAD_AXIS_RIGHT_X)
    self.look.y = -Input.getGamepadAxis(self.gamepad, Input.GAMEPAD_AXIS_RIGHT_Y)
end

function UserInputAdapter:getArrowKeysMovement()
    if Input.isKeyPressed(Input.KEY_LEFT) then self.move.x = 1 end
    if Input.isKeyPressed(Input.KEY_RIGHT) then self.move.x = -1 end
    if Input.isKeyPressed(Input.KEY_UP) then self.move.z = 1 end
    if Input.isKeyPressed(Input.KEY_DOWN) then self.move.z = -1 end

    if Input.isKeyPressed(Input.KEY_A) then self.look.x = 1 end
    if Input.isKeyPressed(Input.KEY_D) then self.look.x = -1 end
    if Input.isKeyPressed(Input.KEY_W) then self.look.y = 1 end
    if Input.isKeyPressed(Input.KEY_S) then self.look.y = -1 end
end

return UserInputAdapter
