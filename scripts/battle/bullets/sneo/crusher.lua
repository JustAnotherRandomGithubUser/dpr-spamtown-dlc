local Crusher, super = Class(YellowSoulBullet)

function Crusher:init(x, y)
    super.init(self, x, y)

    self.shot_health = 3
	
    self.offset = 200
    self.subindex = 0
    self.animtimer = 0
    self.drawcolor = COLORS.white
    self.flash = false
	
    self.difficulty = 1
	
    self.slide_dir = ((Utils.random(1) * 2) - 1) * Utils.random(2, 6)
	
    self.destroying = 0

    self.new_movement = 1
	
    if self.new_movement == 0 then
        self.physics.direction = 180
        self.physics.speed = 0.4
        self.physics.friction = 0
    else
        self.physics.speed_x = -3
        self.physics.speed_y = math.floor(Utils.random(-2, 2))
        self.haccel = 0.4
        self.topy = Game.battle.arena.y - 60
        self.bottomy = Game.battle.arena.y + 60
        self.vbounce = 1
    end
	
    self.updown = 1
    self.crushedObj = 0
    self.maxspeed = 8
    self.destroy_on_hit = false
    self.offsetCap = 0
    self.crushtimer = 0
    self.bul_init = false
    self.siner = 0
    self.creatednewalls = false
    self.pushback = 0
    self.createdguns = 0
    self.start_layer = self.layer
    self.flashsiner = 0
end

function Crusher:update()
    if self.bul_init == false then
        if self.crushedObj > 0 then
            self.maxspeed = self.crushedObj == 2 and 2 or 3
        end
        self.bul_init = true
        if self.new_movement == 0 then
            if self.difficulty ~= 2 then
                self.physics.friction = self.crushedObj == 2 and -2.5 or -0.35
            end
            if self.difficulty == 2 then
                self.physics.friction = self.crushedObj == 2 and -2.5 or -0.1
            end
            if self.difficulty == 5 then
                self.physics.friction = self.crushedObj == 2 and -2.5 or -0.1
            end
        end
        if self.difficulty ~= 1 then
            self.offsetCap = self.crushedObj == 2 and 15 or 0
        end
        if self.crushedObj == 2 then
            self.shot_health = 1
        end
        if self.difficulty == 4 then
            local gun1 = self.wave:spawnBullet(obj_crusher_gun, -15, -44)
            gun1.layer = self.layer - 1
            local gun2 = self.wave:spawnBullet(obj_crusher_gun, -15, 44)
            gun2.layer = self.layer - 1
            self.createdguns = 1
        end
    end
    if self.crushedObj == 1 then
        self.offsetCap = math.max(0, ((self.shot_health - 1) * 15))
    end
    if self.new_movement == 1 then
        self.physics.speed_x = self.physics.speed_x - self.haccel * DTMULT
        if self.vbounce == 1 then
            if self.y > self.bottomy then
                self.y = self.bottomy - 1
                self.physics.speed_y = (-math.abs(self.physics.speed_y))
            end
            if self.y < self.topy then
                self.y = self.topy + 1
                self.physics.speed_y = math.abs(self.physics.speed_y)
            end
        end
    end
    if (self.x >= (SCREEN_WIDTH + 100) or self.x <= -100 or self.y >= (SCREEN_HEIGHT + 100) or self.y <= -100) then
        self:remove()
        if self.creatednewalls == true then
            self.creatednewalls = false
        end
    end
    if self.new_movement == 0 then
        self.x = self.x + self.pushback * DTMULT
        if self.pushback > 0 then
            self.pushback = self.pushback - DTMULT
        end
        if self.pushback == 8 then
            self.layer = self.start_layer
            self.color = COLORS.white
        end
        if self.physics.speed > self.maxspeed then
            self.physics.speed = self.maxspeed
            self.physics.friction = 0
        end
    end
    if self.destroying then
        if self.difficulty ~= 3 and self.difficulty ~= 5 then
            self.destroying = self.destroying + 15 * DTMULT
            self.physics.speed = 0
        end
        if self.difficulty == 3 and self.destroying < 45 then
            self.destroying = self.destroying + 15 * DTMULT
        end
        if self.difficulty == 5 and self.destroying < 45 then
            self.destroying = self.destroying + 15 * DTMULT
        end
        if self.destroying >= 200 then
            if self.creatednewalls == true then
                self.creatednewalls = false
            end
            self:remove()
        end
        return
    end
    if self.crushedObj == 2 and self.offset <= self.offsetCap then
        self.crushtimer = self.crushtimer + DTMULT
        if self.crushtimer == 20 then
            self.offsetCap = self.offsetCap - 7 * DTMULT
        end
        if self.crushtimer > 20 then
            self.active = 0
            self.destroying = 15
            --event_user(1)
        end
    end
    if self.offset <= self.offsetCap and self.new_movement == 0 then
        if self.physics.speed == 0 then
            self.physics.speed = 0.1
        end
        if self.difficulty ~= 2 and self.difficulty ~= 5 and self.difficulty ~= 6 then
            if self.updown then
                local ynext = self.y + self.slidedir
                if (ynext > (Game.battle.arena.y + 60) or ynext < (Game.battle.arena.y - 60)) then
                    self.slidedir = self.slidedir * -1
                end
                self.y = self.y + self.slidedir
            end
        end
        if self.difficulty == 2 or self.difficulty == 5 then
            self.siner = self.siner + 0.5 * DTMULT
            self.y = Game.battle.arena.y + (math.sin(self.siner / 6)) * 50
        end
    end
    if Game.battle.soul and (self.x - 30) < Game.battle.soul.x then
        return
    end
    --[[
    if self.destroying < 1 then
        for i = 0, i < instance_number(obj_yheart_shot); i += 1) do
            enemy[i] = instance_find(obj_yheart_shot, i)
            if (enemy[i].x > (x - 22)) then
                with (enemy[i])
                    event_user(0)
                end
            end
        end
    end
    ]]

    super.update(self)
end

function Crusher:draw()
    super.draw(self)
end

function Crusher:destroy()
    if self.creatednewalls == true then
        self.creatednewalls = false
    end
    if (self.difficulty == 4 and self.createdguns == 1) or (self.difficulty == 6 and self.createdguns == 1) then
    end
end

return Crusher