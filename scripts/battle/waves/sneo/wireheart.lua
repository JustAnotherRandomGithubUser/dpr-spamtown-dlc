local Basic, super = Class(Wave)

function Basic:init()
	super:init(self)
    self.time = -1
	
    self:setArenaPosition(240, 160)
end

function Basic:onStart()
	Game.battle:swapSoul(YellowSoul())

    self.heart_1 = self:spawnBullet("sneo/wireheart", 510, 140)
    self.heart_1.type = 0
end

function Basic:draw()
    super.draw(self)
end

return Basic