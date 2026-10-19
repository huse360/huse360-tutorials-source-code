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

local KeyboardStick = require("Scripts/Input/KeyboardStick")

function UserInputAdapter:init()
    local entity = Object(self.scene, self.entity)
    if not self.playerCoordinator then
        Log.error("playerCoordinator not found in " .. entity.name)
        return
    end

    -- 'self.scene' and 'self.entity' are provided by the engine
    RegisterEngineEvent(self, "onUpdate")
    self.move = Vector3(0,0,0)
    self.look = Vector3(0,0,0)

    if Input.numGamepads() > 0 then
        self.gamepad = Input.getGamepadId(0)
    end

    self.buttons = 0
    self.lastButtons = 0
    self.keyboardStick = KeyboardStick.new(4)
end

function UserInputAdapter:didPressButtonJump()
    if not self.gamepad then return Input.isKeyPressed(Input.KEY_SPACE) end

    return
        Input.isGamepadButtonPressed(self.gamepad, Input.GAMEPAD_BUTTON_A)
        or Input.isKeyPressed(Input.KEY_SPACE)
end

function UserInputAdapter:onUpdate()
    self.keyboardStick:onUpdate()
    self:getGamepadMovement()
    self:getKeyboardMovement()
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
    self.look.z = -Input.getGamepadAxis(self.gamepad, Input.GAMEPAD_AXIS_RIGHT_Y)
end

function UserInputAdapter:getKeyboardMovement()
    if not self.keyboardStick:didMove() then
        if not self.gamepad then
            self:clearMoveAndLook()
        end
        return
    end
    self.move = self.keyboardStick:right()
    self.look = self.keyboardStick:left()
end

function UserInputAdapter:clearMoveAndLook()
    self.move.x = 0
    self.move.z = 0
    self.look.x = 0
    self.look.z = 0
end

return UserInputAdapter
