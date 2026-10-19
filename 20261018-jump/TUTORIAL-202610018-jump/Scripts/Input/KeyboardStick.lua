local KeyboardStick = {}
KeyboardStick.__index = KeyboardStick

function KeyboardStick.new(speed)
  local self = setmetatable({}, KeyboardStick)
  self.rightStick = Vector3(0,0,0)
  self.rightStickTarget = Vector3(0,0,0)

  self.leftStick = Vector3(0,0,0)
  self.leftStickTarget = Vector3(0,0,0)

  self.speed = speed
  
  return self
end

function KeyboardStick:onUpdate()
  self:getKeysInput()
  self.rightStick 
    = self.rightStick:moveTowards(
      self.rightStickTarget, 
      self.speed * Engine.deltatime
    )
  self.leftStick 
    = self.leftStick:moveTowards(
      self.leftStickTarget, 
      self.speed * Engine.deltatime
    )
end

function KeyboardStick:left()
  return self.leftStick
end

function KeyboardStick:right()
  return self.rightStick
end

function KeyboardStick:didMove()
  return
    self.rightStick:squaredLength() > 0.1
    or
    self.leftStick:squaredLength() > 0.1
end

function KeyboardStick:getKeysInput()
    self.rightStickTarget.x = 0
    self.rightStickTarget.z = 0
    self.leftStickTarget.x = 0
    self.leftStickTarget.z = 0

    if Input.isKeyPressed(Input.KEY_LEFT) then self.rightStickTarget.x = 1 end
    if Input.isKeyPressed(Input.KEY_RIGHT) then self.rightStickTarget.x = -1 end
    if Input.isKeyPressed(Input.KEY_UP) then self.rightStickTarget.z = 1 end
    if Input.isKeyPressed(Input.KEY_DOWN) then self.rightStickTarget.z = -1 end

    if Input.isKeyPressed(Input.KEY_A) then self.leftStickTarget.x = 1 end
    if Input.isKeyPressed(Input.KEY_D) then self.leftStickTarget.x = -1 end
    if Input.isKeyPressed(Input.KEY_W) then self.leftStickTarget.z = 1 end
    if Input.isKeyPressed(Input.KEY_S) then self.leftStickTarget.z = -1 end

    self.rightStickTarget:normalize()
    self.leftStickTarget:normalize()
end

return KeyboardStick