local StaticWall, super = Class(YellowSoulBullet)

function StaticWall:init(x, y)
    super.init(self, x, y, "battle/bullets/sneo/box")
	
    self.element = 6
    self.f = 2
	
    self.destroyable = false
    self.angle_speed = 0
    self.yellowsiner = 0
	
    self.loop = false
    self.loopy1 = 90
    self.loopy2 = 240
	
    self.falsevspeed = 0
    self.bighitbox = 1
    self.angleadjust = 0
    self.active = false
    self.siner = 0
	
    self.altdir = 0
    self.altspeed = 0
    self.altfriction = 0
    self.altgravity = 0
	
    self.changedirection = 0
    self.bulletspeed = 8
    self.hspeed = 0
    self.friction = 0
	
    self.xx = Game.battle.arena.x
    self.xdist = (self.init_x - self.xx)
	
    self.bullet_init = false
    self.startdepth = 0
	
    self.scale_x = 1.2
    self.scale_y = 1.2
	
    --[[if instance_exists(obj_spamton_neo_enemy)
        self.damage = (global.monsterat[obj_spamton_neo_enemy.myself] * 5)
	end
    if instance_exists(obj_sneo_bulletcontroller)
        self.target = obj_sneo_bulletcontroller.target
	end]]
	
    self.tp = 2
    self.alpha = 1
end

function StaticWall:update()
    super.update(self)
	
    if self.alpha < 1 then
        self.alpha = self.alpha + 0.04 * DTMULT
    end
	
    if self.bullet_init == false then
        self.startdepth = (Game.battle.arena.layer + self.layer)
        self.bullet_init = true
    end
    if self.x >= (SCREEN_WIDTH + 100) or self.x <= -100 or self.y >= (SCREEN_HEIGHT + 100) or self.y <= -100 then
        self:remove()
    end
    self.physics.direction = self.physics.direction + self.angle_speed
    if self.angleadjust == 1 then
        self.rotation = self.physics.direction
    end
    if self.destroyable == true then
        self.yellowsiner = self.yellowsiner + DTMULT
        self.color = Utils.mergeColor(COLORS.yellow, COLORS.orange, (0.25 + (math.sin((self.yellowsiner / 3)) * 0.25)))
    end
    --self.sinespeed = obj_sneo_wall_controller.sinespeed
    self.siner = self.siner + self.sinespeed * DTMULT
    self.x = (self.xx + (math.cos(((-self.siner) / 20)) * self.xdist))
    local _falsedepth = math.sin((self.siner / 20))
    self.active = _falsedepth >= 1
    --local _depthblend = Utils.clamp((_falsedepth + 0.5), 0, 1)
    --self.color = Utils.mergeColor(COLORS.gray, COLORS.white, _depthblend)
    self.layer = ((Game.battle.arena.layer - (_falsedepth * self.startdepth)) - 3)
    if self.bighitbox == 1 then
        self.collider = Hitbox(self.x, self.y, self.width, self.height)
        --[[if (hitshot ~= -4)
            event_user(0)
		end]]
    end
end

function StaticWall:onYellowShot(shot)
	
    if self.destroyable == true and self.active == true then
        Assets.playSound("damage")
	end
	
    return "c", false
end

return StaticWall