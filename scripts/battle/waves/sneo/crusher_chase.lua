local Basic, super = Class(Wave)

function Basic:init()
	super:init(self)
    self.time = -1
	
    self:setArenaPosition(240, 160)
end

function Basic:onStart()
	Game.battle:swapSoul(YellowSoul())

    local crusher_chase = self:spawnBullet("sneo/crusher_chase", 480, 160)
end

return Basic