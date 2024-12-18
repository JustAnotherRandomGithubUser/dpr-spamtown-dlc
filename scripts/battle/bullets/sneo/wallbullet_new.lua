local WallBulletNew, super = Class(YellowSoulBullet)

function WallBulletNew:init(x, y)
    super.init(self, x, y, "battle/bullets/sneo/lilguy")

    self.timer = 0
    self.shot_health = 1
	
    self.destroyable = true
    self.red = false
    self.bighitbox = true
	
    self.tp = 2
	
    self.wallcontroller = -1
    self.wallspeed = -7
    self.wallnumber = 0
    self.walltype = 0
	
    self:setColor(Utils.mergeColor({0/255, 162/255, 232/255}, COLORS.aqua, (0.25 + math.sin(0) * 0.25)))
end

function WallBulletNew:update()
    super.update(self)
	
    if self.sprite:isSprite("battle/bullets/sneo/lilguy") then
        self:setHitbox(0, 0, 19, 22)
    elseif self.sprite:isSprite("battle/bullets/sneo/mail_1") then
        self:setHitbox(0, 0, 18, 18)
    elseif self.sprite:isSprite("battle/bullets/sneo/wall_box") then
        self:setHitbox(0, 0, 20, 20)
    end
	
    for _,wave in ipairs(Game.battle.waves) do
        if wave.id == "sneo/wallcarts" then
            if self.collider.collidable then
                self.x = self.x + wave.wallspeed[self.wallnumber] * DTMULT
            end

            if self.wallcontroller > -1 then
                if wave.walltype[self.wallnumber] == 0 then
                    self.timer = self.timer + DTMULT
                    if self.timer < 9 then
                        wave.wallspeed[self.wallnumber] = Utils.lerp(-16, -6, (self.timer / 9))
                    elseif self.timer < 150 then
                        wave.wallspeed[self.wallnumber] = Utils.lerp(-6, -6, ((self.timer - 9) / 130))
                    end
                end
				
                if wave.walltype[self.wallnumber] == 1 then
                    self.timer = self.timer + DTMULT
                    if self.timer < 16 then
                        wave.wallspeed[self.wallnumber] = Utils.lerp(-21, -5, (self.timer / 15))
                    elseif self.timer < 90 then
                        wave.wallspeed[self.wallnumber] = Utils.lerp(-5, -13, ((self.timer - 15) / 70))
                    end
                end
            end
        end
    end
end

function WallBulletNew:onYellowShot(shot)
    if self.destroyable then
        if self.red then
            self:destroy()
        else
            self:destroy()
        end
    else
        if shot.big then
            shot:remove()
        end
        Assets.playSound("bell")
    end

    return "c", false
end

function WallBulletNew:destroy()
    self.collider.collidable = false
    Assets.playSound("bomb", 0.7, 1.1 + Utils.random(0.2))
	
	local death = AfterImageCut(self.sprite:getTexture(), function() self:remove() end)
	death:setScale(self.sprite:getScale())
    death:setColor(self.color)
	self:addChild(death)
	self.sprite.alpha=0
end

return WallBulletNew