local CrusherChase, super = Class(YellowSoulBullet)

function CrusherChase:init(x, y)
    super.init(self, x, y)

    self.shot_health = 30
	
    self:setHitbox(0, -8, 16, 16)
	
    self.offset = 400
    self.subindex = 0
    self.subindex2 = 0
    self.animtimer = 0
    self.drawcolor = COLORS.white
    self.flash = false
	
    self.difficulty = 1
	
    self.slide_dir = ((Utils.random(1) * 2) - 1) * Utils.random(2, 6)
	
    self.destroying = 0
	
    self.shoot_timer = 29
	
    self.piston_x, self.piston_y = 24, 0
	
    self.physics.speed_y = Utils.pick{4, -4}
    self.top_y = Game.battle.arena.y - 60
    self.bottom_y = Game.battle.arena.y + 60
    self.vbounce = 1
    self.updown = 1
	
    self.crushed_obj = 0
	
    self.maxspeed = 8
	
    self.destroy_on_hit = false
	
    self.offset_cap = 0

    self.crush_timer = 0
    self.bul_init = false
    self.siner = 0
    self.pushback = 0
    self.flashsiner = 0
	
    self.alpha = 0
end

function CrusherChase:update()
    super.update(self)
	
    if self.bul_init == false then
        self.bul_init = true
        if self.crushed_obj ~= 1 then
            self.offset_cap = (self.crushed_obj == 2) and 15 or 0
        end
    end
	
    if self.vbounce == 1 then
        if self.y > self.bottom_y then
            --self.bottom_y = self.bottom_y - DTMULT
            self.physics.speed_y = -math.abs(self.physics.speed_y)
			Assets.playSound("screenshake", 0.8)
            Game.battle.camera:shake(4)
        end
        if self.y < self.top_y then
            --self.top_y = self.top_y + DTMULT
            self.physics.speed_y = math.abs(self.physics.speed_y)
			Assets.playSound("screenshake", 0.8)
            Game.battle.camera:shake(4)
        end
    end
	
    self.siner = self.siner + 0.4*DTMULT
	
    self.x = self.init_x + (math.sin((self.siner / 6)) * 60)
	
    self.shoot_timer = self.shoot_timer + DTMULT
    if self.shoot_timer >= 54 then
        local b = 0
        for i = 1, 3 do
            local radialshot = self.wave:spawnBullet("bullets/rudinn/diamond_white", self.x, self.y)
            radialshot.physics.direction = Utils.angle(radialshot.x, radialshot.y, Game.battle.soul.x, Game.battle.soul.y)
            radialshot.rotation = radialshot.physics.direction
            radialshot:setScale(1)
            radialshot:setColor(COLORS.red)
            radialshot.physics.speed = 3.5
            radialshot.physics.friction = -0.33 + b
			
            self.shoot_timer = 0
            b = b + 0.07000000000000001 * DTMULT
        end
    end
end

function CrusherChase:draw()
    super.draw(self)
	
    self.flashsiner = self.flashsiner + DTMULT
    self.crush_timer = self.crush_timer + DTMULT
    self.alpha = self.alpha + 0.1 * DTMULT
	
    local blend_color = Utils.merge({0/255, 162/255, 232/255}, COLORS.aqua, (0.25 + math.sin(self.flashsiner / 3)) * 0.25)
	
    if self.destroying == 0 and self.offset > 0 then
        if self.offset > self.offset_cap then
            self.offset = -20
        end

        Draw.draw(Assets.getTexture("battle/bullets/common/dollar"), self.x, self.y, 0, 0.5, 0.5)

        if self.crush_timer >= 10 and self.offset == self.offset_cap and self.offset > 0 then
            self.offset = self.offset + DTMULT
            self.crush_timer = 10
	    elseif self.offset < self.offset_cap then 
            self.offset = self.offset_cap
        end

        self.drawcolor = COLORS.white
    end
	
    local head = Assets.getFrames("battle/bullets/sneo/crusher/head_top")
    local jaw = Assets.getFrames("battle/bullets/sneo/crusher/head_bottom")
    self.subindex = math.floor(self.subindex + 0.4 * DTMULT) % #head + 1 
	
    if self.offset <= self.offset_cap then
        if self.offset == 0 then
            self.drawcolor = blend_color
        end
		
        self.animtimer = self.animtimer + DTMULT
		
        if self.animtimer > 1 then
            self.animtimer = 0
        end
    end
	
    local s = 1
	
    Draw.setColor(1, 1, 1, self.alpha)
    Draw.draw(Assets.getTexture("battle/bullets/sneo/crusher/thick"), self.piston_x, (self.piston_y - self.offset), 0, (s * -1), -16)
    Draw.draw(Assets.getTexture("battle/bullets/sneo/crusher/thick"), self.piston_x - 32, (self.piston_y - self.offset), 0, s, 16)
    Draw.draw(Assets.getTexture("battle/bullets/sneo/crusher/piston"), self.piston_x, (self.piston_y - self.offset), 0, (s * -1), s)
    if ((self.y + self.offset) < 310) then
        Draw.draw(Assets.getTexture("battle/bullets/sneo/crusher/piston"), self.piston_x, (self.piston_y + self.offset), 0, (s * -1), (-s))
    end
    Draw.draw(head[self.subindex], self.piston_x - 32, (self.piston_y - self.offset - 10), 0, s, s)
    if ((self.y + self.offset) < 310) then
        Draw.draw(jaw[self.subindex], self.piston_x - 32, (self.piston_y - self.offset + 10), 0, s, s)
    end
end

return CrusherChase