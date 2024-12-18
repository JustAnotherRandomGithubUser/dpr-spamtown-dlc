local WireHeart, super = Class(YellowSoulBullet)

function WireHeart:init(x, y)
    super.init(self, x, y)
	
    self:setHitbox(-8, -16, 24, 35)
	
    self.heart_spr = Assets.getFrames("battle/bullets/sneo/wireheart/big/heart")
    self.heart_frame = 1

    self.hp = 300
    self.damagetimer = 0
    self.defeated = 0

    self.destroy_on_hit = false
	
    self.animtimer = 0
    self.firedtimer = 0
    self.destroyed = false
	
    self.rembossx = 0
    self.rembossy = 0
    self.invincibility_timer = 2
	
    self.chargeshothitcount = 0
    self.normalshothitcount = 0

    self.scale_x = 1
    self.scale_y = 1
    self.minscale = 0.5
    self.maxscale = 1
	
    self.bossx = self.init_x
    self.bossy = self.init_y
    self.boss = Game.battle:getEnemyBattler("sneo")

    self.heart_init = false
	
    self.con = 1
    self.timer = 0
    self.moveframes = 30
    self.target_x = 0
	
    self.type = 0
    self.shottype = 0
    self.bighearttype = 0
    self.special = 0
    self.preset = -1
    self.altbiter = 2
    self.hpos = 5 + Utils.random(1.5)
end

function WireHeart:update()
    super.update(self)

    if self.heart_init == false then
        self.destroyed = false
		
        self.shotcount = 0
        self.bouncecount = 0
        self.shottype = 0
        self.shottimer = 0
		
        self.heart_init = true 
        self.con = 1

        if self.boss then
            self.rembossx = self.boss.x
            self.rembossy = self.boss.y
        else
            self.rembossx = self.bossx
            self.rembossy = self.bossy
        end
		
        if self.type == 1 then
            self.maxscale = 1
            self.heart_spr = Assets.getFrames("battle/bullets/sneo/wireheart/small/heart")
            self.moveframes = self.moveframes + DTMULT * 0.8
            self.hp = 10
        end

        if self.type == 3 then
            self.heart_spr = Assets.getFrames("battle/bullets/sneo/wireheart/biter/heart")
            self.hp = 3
            self.moveframes = 12
        end
        if self.type == 4 then
            self.heart_spr = Assets.getFrames("battle/bullets/sneo/wireheart/bomb/heart")
            self.hp = 1
        end
    end

    if self.con == 1 then
        if self.bighearttype == 1 then
            self.moveframes = 16
        end
		
        self.target_x = 300 + Utils.random(70)
        self.target_y = 145 + Utils.random(-70, 70)
		
        if self.type == 3 then
            if self.altbiter > 0 and self.altbiter < 3 then
                self.target_x = 150
                if self.altbiter == 1 then
                    self.target_y = 240
                else
                    self.target_y = 75
                end
            else
                self.target_x = 170 + Utils.random(70)
                self.target_y = 145 + Utils.random(-60, 60)
            end
            if self.altbiter == 3 then
                self.target_x = 350
                self.target_y = 130 + Utils.random(-45, 0)
            end
            if self.altbiter == 4 then
                self.target_x = 350
                self.target_y = 160 + Utils.random(45, 0)
            end
        end
		
        local soul = Game.battle.soul
        if soul --[[and obj_sneo_bulletcontroller.hearttargettimer < 1]] and self.type ~= 3 then
            if Utils.pick{0, 1, 2} == 0 then
                self.target_y = soul.y + 10
                --obj_sneo_bulletcontroller.hearttargettimer = 6
            end
        end
		
        self.movetimer = 0
        self.con = 2
		
        if self.type == 0 or self.type == 1 then
            if self.boss then
                self.boss.heart_release_con = 1
            end
        end
    end

    if self.con == 2 then
        self.movetimer = self.movetimer + (1 / self.moveframes)
        self.x = Utils.ease(self.bossx, self.target_x, self.movetimer, "out-sine")
        self.y = Utils.ease(self.bossy, self.target_y, self.movetimer, "out-sine")
        if self.movetimer >= 1 then
            self.movetimer = 0
            self.con = 3
        end
    end

    if self.con == 3 then
        if self.type == 3 and self.altbiter > 0 and self.altbiter < 3 then
            self.movetimer = self.movetimer + DTMULT
            if self.altbiter == 1 then
                self.y = Utils.lerp(240, 75, (self.movetimer / 21))
            end
            if self.altbiter == 2 then
                self.y = Utils.lerp(75, 240, (self.movetimer / 21))
            end
            if self.movetimer >= 20 then
                self.movetimer = 0
                self.con = 10
                self.target_y = self.y
            end
        end
        if self.type == 3 and self.altbiter > 2 then
            self.movetimer = self.movetimer + DTMULT
            if self.movetimer == 1 then
                --self:spawnBullet("obj_sneo_heart_laser", self.x, self.y)
            end
            if self.movetimer >= 16 then
                self.movetimer = 0
                self.con = 10
            end
        else
            self.con = 10
            self.movetimer = 0
        end
    end
	
    if self.con == 10 then
        self.movetimer = self.movetimer + (1 / self.moveframes)
        self.x = Utils.ease(self.target_x, self.bossx, self.movetimer, "in-sine")
        self.y = Utils.ease(self.target_y, self.bossy, self.movetimer, "in-sine")
        if (self.movetimer > 0.5 and self.type == 0) or (self.movetimer > 0.5 and self.type == 1 --[[and self.boss.difficulty > 2]]) then
            if self.boss then
                self.boss.heart_release_con = 0
            end
        end
		
        if self.movetimer >= 1 then
            self.movetimer = 0
            self.shottimer = 0
            self.con = 1
        end
    end
	
    if self.con == 2 or (self.con == 3 or self.con == 10) then
        local radial = 5
    end
end

function WireHeart:onYellowShot(shot)
    if self.invincibility_timer > 0 and not shot.big then
        shot:remove()
    end
    self.invincibility_timer = 10
    --[[if Game.battle.wave_timer < 150 then
        self.hp = 0
        if self.type == 0 or (self.type == 1 and self.boss.difficulty > 2 and Game.battle.wave_timer < 20) then
            --Game.battle.wave_timer = 20
            self.hp = 0
            self.destroyed = true
        end
    else
        if self.type == 0 or (self.type == 1 and self.boss.difficulty > 2) then
            if shot.big then
                --Game.battle.wave_timer = Game.battle.wave_timer - (80 - (self.chargeshothitcount * 10))
                if self.chargeshothitcount < 3 then
                    self.chargeshothitcount = self.chargeshothitcount + DTMULT
				end
            else
                --Game.battle.wave_timer = Game.battle.wave_timer - (20 - normalshothitcount)
                if self.normalshothitcount < 10 then
                    self.normalshothitcount = self.normalshothitcount + DTMULT
                end
            end
        elseif shot.big then
            self.hp = self.hp - 5
        else
            self.hp = self.hp - 1
        end
    end]]

    self.damagetimer = 5
    Assets.playSound("damage")
	
    if self.hp <= 0 then
        self.destroyed = true
    end
	
    shot:remove()
end

function WireHeart:draw()
    super.draw(self)
	
    --reset origin to top left corner of window being 0,0
    local old_transform = love.graphics.pop()
	
    if self.boss then
        local xx = 50 - self.boss.heart_release_con * 100
        if Game.battle.wave_timer > 20 then
            xx = 0
        end
        self.rembossx = Utils.lerp(self.rembossx, (self.boss.x + xx), 0.16)
        self.rembossy = self.boss.y + 80
    end
	
    if self.destroyed == true then
        self.invincibility_timer = 0
    end
	
    local hidesprite = false
   
    if self.invincibility_timer > 0 then
        if self.invincibility_timer == 10 or self.invincibility_timer == 9 or self.invincibility_timer == 6 or self.invincibility_timer == 5 or self.invincibility_timer == 3 or self.invincibility_timer == 2 then
            self.hidesprite = true
        end
        self.invincibility_timer = self.invincibility_timer - DTMULT
    end
	
    if hidesprite == false then
	    local spike_chain = Assets.getTexture("battle/bullets/sneo/wireheart/spike_chain")
	    local chain = Assets.getTexture("battle/bullets/sneo/wireheart/chain")
		
        if self.type == 3 and self.altbiter > 0 and self.altbiter < 3 then
            if self.altbiter == 1 then
                for i = 0, 5 do
                    Draw.draw(spike_chain, Utils.lerp(self.x, self.rembossx, (i / 5)), Utils.lerp(self.y, self.rembossy, (i / 5)), 0, 0.75, 0.75, spike_chain:getWidth()/2, spike_chain:getHeight()/2)
                end
            else
                for i = 0, 5 do
                    Draw.draw(spike_chain, Utils.lerp(self.x, self.rembossx, (i / 6)), Utils.lerp(self.y, self.rembossy, (i / 5)),0,  0.75, 0.75, spike_chain:getWidth()/2, spike_chain:getHeight()/2)
                end
            end
        else
            for i = 0, 9 do
                Draw.draw(chain, Utils.lerp(self.x, self.rembossx, (i / 9)), Utils.lerp(self.y, self.rembossy, (i / 9)), 0, self.scale_x, self.scale_y, chain:getWidth()/2, chain:getHeight()/2)
            end
        end
        
		self.animtimer = self.animtimer + DTMULT
        self.firedtimer = self.firedtimer - DTMULT
        self.heart_frame = 1
		
        if self.animtimer >= 5 then
            self.heart_frame = 2
        end
        if self.animtimer >= 10 then
            self.animtimer = 0
        end
        if self.firedtimer > 4 then
            self.heart_frame = 4
        end

        if self.damagetimer > 0 then
            love.graphics.setColor(1, 1, 1, (self.damagetimer / 5))
            Draw.draw(self.heart_spr[3], self.x, self.y, 0, self.scale_x, self.scale_y, self.heart_spr[3]:getWidth()/2, self.heart_spr[3]:getHeight()/2)
            self.damagetimer = self.damagetimer - DTMULT
        else
            local heart = self.heart_spr[self.heart_frame]
            love.graphics.setColor(1, 1, 1, 1)
            Draw.draw(heart, self.x, self.y, 0, self.scale_x, self.scale_y, heart:getWidth()/2, heart:getHeight()/2)
        end
    end

    --reset transform stack	
    love.graphics.push(old_transform)
end

return WireHeart