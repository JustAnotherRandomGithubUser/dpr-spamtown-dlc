local HeartAttackBullet, super = Class(Bullet)

function HeartAttackBullet:init(x, y)
    super.init(self, x, y, "battle/bullets/sneo/heart_bullet")
	
    self.f = 1
    self.angle_speed = 0
    self.newtype = 0
    self.timer = 0
end

function HeartAttackBullet:update()
    super.update(self)
	
    --self.physics.rotation = dir
    self.f = self.f + 1.4 * DTMULT
    self.x = self.x + (math.cos(self.physics.direction) * self.f) * DTMULT
    self.y = self.y + (math.sin(self.physics.direction) * self.f) * DTMULT
end

return HeartAttackBullet