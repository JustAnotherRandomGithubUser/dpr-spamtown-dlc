local SneoBomb, super = Class(YellowSoulBullet)

function SneoBomb:init(x, y)
    super:init(self, x, y, "battle/bullets/common/sneobomb", dir, speed)
    self.sprite:play(-1, true)
    self:setScale(1, 1)
    self.collidable = true
    self.destroy_on_hit = false
end

function SneoBomb:onYellowShot(shot, damage)
    self.wave.timer:script(function(wait)
        self.collidable = false
        Assets.playSound("bump")
        Assets.playSound("bombfall")
        self.sprite:play(0.05, true)
        wait(0.07)
        Assets.playSound("bombfall")
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

function SneoBomb:update()
    super:update(self)
end


return SneoBomb