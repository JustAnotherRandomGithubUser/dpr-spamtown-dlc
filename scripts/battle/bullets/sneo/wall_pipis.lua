local WallPipis, super = Class(YellowSoulBullet)

function WallPipis:init(x, y)
    super.init(self, x, y, "battle/bullets/common/pipis/yellow/pipis", dir, speed)
    self.sprite:play(-1, true)
    self:setScale(2, 2)
    self.collidable = true
    self.destroy_on_hit = false
    self:setHitbox(self.sprite.width/2 - 6, -4, 12, 18)

    self.wallspeed = -7
    self.wallnumber = 0
	
    self.timer = Timer()
    self:addChild(self.timer)
end

function WallPipis:update()
    super.update(self)

    for _,wave in ipairs(Game.battle.waves) do
        if wave.id == "sneo/wallcarts" then
            if self.collidable then
                self.x = self.x + wave.wallspeed[self.wallnumber] * DTMULT
            else
                self.x = self.x + (3 - Utils.random(6)) * DTMULT
                self.y = self.y + (3 - Utils.random(6)) * DTMULT
            end
        end
    end
end

function WallPipis:onYellowShot(shot, damage)
    self.timer:script(function(wait)
        self.collidable = false
        Assets.playSound("bump")
        self.sprite:setSprite("battle/bullets/sneo/pipis/yellow/pipis_broken3")
        wait(0.08)
        Assets.playSound("voice/spam")
        wait(0.08)
        Assets.playSound("voice/spam")
        wait(0.08)
        Assets.playSound("bomb")
		
        for i=1,3 do
            local piece = Sprite("battle/bullets/sneo/pipis/yellow/piece", self.x, self.y)
            piece.layer = 800
            piece:play(0.05, true)
            piece:setScale(2)
            piece.physics.direction = math.rad(Utils.random(360))
            piece.rotation = math.rad(0) + 15
            piece.graphics.spin = 0.15
            piece.physics.speed = 4
            piece.physics.gravity = 0.2
            piece.alpha = 3
            piece.graphics.fade_to = 0
            piece.graphics.fade_callback = function() piece:remove() end
            piece.graphics.fade = 0.1
            Game.battle:addChild(piece)
        end
        
        for i = 1, 12 do
            local radialbullet = self.wave:spawnBullet("sneo/heatattack_bullet", self.x, self.y)
            radialbullet:setSprite("battle/bullets/sneo/diamond_white")
            radialbullet:setScale(1,1)
            radialbullet.physics.direction = i * 30 --[[+ Utils.random(28) - 14]]
            radialbullet.rotation = radialbullet.physics.direction
            radialbullet.physics.match_rotation = true
        end
        self:destroy()
    end)
    if Game:getMaxTension() > Game.tension then
       Game.tension = Game.tension + 1
    end
    return "a", false
end


return WallPipis