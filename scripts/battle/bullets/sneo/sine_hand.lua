local SineHand, super = Class(Bullet)

function SineHand:init(x, y)
    super.init(self, x, y, "battle/bullets/sneo/hand")

    self.con = 0
    self.siner = 0
    self.alpha = 0
end

function SineHand:update()
    super.update(self)
	
    if self.con == 0 and self.alpha < 1 then
        self.alpha = self.alpha + 0.04*DTMULT
    end
	
    if self.con == 1 then
        self.alpha = self.alpha - 0.04*DTMULT
    end
	
    if self.con == 1 and self.alpha < 0 then
        self:remove()
    end

    if self.x < -21 then
        self.x = SCREEN_WIDTH + 21
    end

    self.siner = self.siner + 0.4*DTMULT
    self.y = self.init_y + (math.sin((self.siner / 4)) * 20)
end

return SineHand