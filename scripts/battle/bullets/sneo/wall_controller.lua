local SNEOWallController, super = Class(Bullet)

function SNEOWallController:init(x, y)
    super.init(self, x, y)
	
    self.collider = nil
	
    self.siner = 0
    self.xx = 0
    self.yy = 0
    self.wallsize = 4
    self.sinespeed = 0
    self.sinetargetspeed = 1.2
	
    self.spawncount = 5
    self.ready_to_turn = 172
    self.made = 0
	
    self.waittime = 125.66370614359172 / self.spawncount
    self.timer = self.waittime
    self.type = 3
    self.brake = 0
    self.has_started = false
	
    self.breakspotconsecutive = (1 + Utils.random(6))
    self.breakspotpreviouscon = 0
    self.introtimer = 0
    self.turnaroundcon = 0
	
    self.difficulty = 1 --Game.battle:getEnemyBattler("sneo").difficulty
    self.lilguytimer = -91
end

function SNEOWallController:update()
    super.update(self)
	
    if self.introtimer > 24 then
        if self.type < 3 then
            self.timer = self.timer + DTMULT
        else
            self.timer = self.timer + self.sinespeed * DTMULT
		end
        if self.sinespeed ~= self.sinetargetspeed then
            --self.sinespeed = self:slideTo(sinespeed, sinetargetspeed, 0.05)
		end
    else
        self.introtimer = self.introtimer + DTMULT
    end
	
    --[[if self.difficulty == 2 then
        self.lilguytimer = self.lilguytimer + DTMULT
        if self.lilguytimer == 76 then
            local guymaker = self:spawnObject(SNEOGuyMaker())
            --guymaker.alarm[0] = 30
        end
        if self.lilguytimer == 172 then
            local guymaker = self:spawnObject(SNEOGuyMaker())
            --guymaker.alarm[0] = 30
        end
    end]]
	
    if self.sinetargetspeed < 0 then
    end
	
    if self.has_started == false and self.type == 3 then
        for j = 0, self.spawncount-1 do
            for i = 0, 2 do
                local bullet = self.wave:spawnBullet("sneo/staticwall", Game.battle.arena.x + 150, ((self.yy / 2) + (i * 5) * 40) - 170)
                bullet.scale_x = 1.25
                bullet.scale_y = 1.6
                bullet.siner = (self.waittime * j)
            end
        end
        self.has_started = true
    end
	
    --[[if self.type == 3 then
        if self.timer >= self.waittime and self.made < self.spawncount then
            for j = 0, self.spawncount-1 do
                if self.breakspotpreviouscon > 3 then
                    self.breakspotpreviouscon = 0
                end
                if self.breakspotpreviouscon == 0 or self.breakspotpreviouscon == 1 then
                    self.breakspotconsecutive = (2 + Utils.random(1))
                    if self.breakspotpreviouscon == 0 then
                        self.physics.speed_y = -1.5
                        self.breakspot1 = self.breakspotconsecutive - 1
                        self.breakspot2 = self.breakspotconsecutive
                        self.breakspot3 = self.breakspotconsecutive + 2
                        self.breakspot4 = self.breakspotconsecutive + 3
                    end
                    if self.breakspotpreviouscon == 1 then
                        self.physics.speed_y = 2
                        self.breakspotconsecutive = 1
                        self.breakspot1 = self.breakspotconsecutive
                        self.breakspot2 = self.breakspotconsecutive + 1
                        self.breakspot3 = self.breakspotconsecutive + 3
                        self.breakspot4 = self.breakspotconsecutive + 4
                    end
                end
                if self.breakspotpreviouscon == 2 or self.breakspotpreviouscon == 3 then
                    self.breakspotconsecutive = (1 + Utils.random(4))
                    self.physics.speed_y = 0
				
                    local a = Utils.random(1)
                    self.breakspot1 = (1 + a)
                    self.breakspot2 = (2 + a)
                    self.breakspot3 = (3 + a)
                    self.breakspot4 = (2 + a)
                    if self.breakspotpreviouscon == 3 then
                        self.breakspot1 = (3 + a)
                        self.breakspot2 = (4 + a)
                        self.breakspot3 = (5 + a)
                        self.breakspot4 = (4 + a)
                    end
                end
			
                self.breakspotpreviouscon = self.breakspotpreviouscon + DTMULT
                self.breakspotpreviouscon = self.breakspotpreviouscon + DTMULT
                self.wallsize = 7
                local sineroffset = ((self.timer - self.waittime) + self:slideTo(self.sinespeed, self.sinetargetspeed, 0.05))
			
                for i = 0, self.wallsize-1 do
                    local bullet = self.wave:spawnBullet("sneo/wallbullet", (Game.battle.arena.x + 150), ((((self.yy / 2)) + (i * 30)) - 100) - 60))
                    bullet:setSprite("spr_sneo_mail")
                    bullet.scale_x = 1
                    bullet.scale_y = 1.5
                    bullet.falsevspeed = self.physics.speed_y
                    bullet.loop = true
                    bullet.siner = sineroffset
                    bullet.siner = (self.waittime * j)
                    if self.breakspot1 == i or self.breakspot2 == i or self.breakspot3 == i or self.breakspot4 == i then
                        bullet.destroyable = true
                        bullet:setSprite("spr_sneo_crew_ez_hitbox")
                        bullet:play(0.5, true)
                        bullet.scale_y = 1
                        bullet.sprite.alpha = 0
                    end
                end
                self.timer = self.timer - self.waittime * DTMULT
                self.made = self.made + DTMULT
            end
        end
    end]]

    if self.timer >= self.ready_to_turn then
	    if self.turnaroundcon == 0 then
            if self.timer >= 3 then
                self.sinetargetspeed = -1.1
                --alarm[0] = 98
            end
		end
        if self.turnaroundcon == 1 then
            if self.timer >= 3 then
                self.sinetargetspeed = 1.2
            end
        end
        self.turnaroundcon = self.turnaroundcon + DTMULT
	end
end

return SNEOWallController