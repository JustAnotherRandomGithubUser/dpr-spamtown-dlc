local WallBomb, super = Class(YellowSoulBullet)

function WallBomb:init(x, y)
    super.init(self, x, y, "battle/bullets/common/sneobomb", dir, speed)
    self.sprite:play(-1, true)
    self:setScale(1, 1)
    self.collidable = true
    self.destroy_on_hit = false

    self.wallspeed = -7
    self.wallnumber = 0
	
    self.timer = Timer()
    self:addChild(self.timer)
end

function WallBomb:update()
    super.update(self)

    for _,wave in ipairs(Game.battle.waves) do
        if wave.id == "sneo/wallcarts" then
            if self.collidable then
                self.x = self.x + wave.wallspeed[self.wallnumber] * DTMULT
            end
        end
    end
end

function WallBomb:onYellowShot(shot, damage)
    self.timer:script(function(wait)
        self.collidable = false
        Assets.playSound("bump")
        Assets.playSound("bombfall")
        self.sprite:play(0.05, true)
        wait(0.07)
        Assets.playSound("bombfall")
        wait(0.07)
        Assets.playSound("bomb")
        Game.battle:shakeCamera(4)
        self.wave:spawnBullet("sneobomb2", self.x, self.y + 3, 0)
        for i = 1, 24 do
           self.wave:spawnBullet("sneobomb3", self.x - 24*i, self.y + 3, 1.571)
           self.wave:spawnBullet("sneobomb3", self.x + 24*i, self.y + 3, 1.571)
           self.wave:spawnBullet("sneobomb3", self.x, self.y + 3 + 24*i, 0)
           self.wave:spawnBullet("sneobomb3", self.x, self.y + 3 - 24*i, 0)
        end
        self:destroy()
    end)
    if Game:getMaxTension() > Game.tension then
       Game.tension = Game.tension + 1
    end
    return "a", false
end


return WallBomb