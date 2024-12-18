local WeirdEndPipisBullet, super = Class(YellowSoulBullet)

function WeirdEndPipisBullet:init(x, y, dir, speed)
    super.init(self, x, y)
	
	self:setScale(1,1)
	
    self.timer = 0
    self.con = 0
    self.target = 1
    self.damage = 16
	
	self.collider = CircleCollider(self, 12, 10, 10)

    self.remove_offscreen = false
	
    self.blue_siner = 0
end

function WeirdEndPipisBullet:update()
    super.update(self)
	
    self.blue_siner = self.blue_siner + DTMULT
    self:setColor(Utils.mergeColor({0/255, 162/255, 232/255}, COLORS.aqua, (0.25 + math.sin(self.blue_siner / 3)) * 0.25))
end

function WeirdEndPipisBullet:destroy()
    Assets.playSound("bomb", 0.5, 1.1 + Utils.random(0.2))
    self.collider.collidable = false
    self.physics = {direction = 0, speed = 0, gravity = 0, friction = 0}
	
	local death = AfterImageCut(self.sprite:getTexture(), function() self:remove() end)
	death:setScale(self.sprite:getScale())
    death:setColor(self.color)
	self:addChild(death)
	self.sprite.alpha=0
end

return WeirdEndPipisBullet