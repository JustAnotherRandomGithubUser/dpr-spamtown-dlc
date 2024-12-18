local Basic, super = Class(Wave)

function Basic:init()
	super:init(self)
    self.time = -1
	
    self:setArenaPosition(240, 160)
end

function Basic:onStart()
	Game.battle:swapSoul(YellowSoul())

    self:spawnBullet("sneo/wall_controller", 0, 0)
end

return Basic