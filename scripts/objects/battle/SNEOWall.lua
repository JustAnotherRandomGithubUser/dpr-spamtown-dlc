local SNEOWall, super = Class(Object)

function SNEOWall:init()
	super.init(self)
	
    self.wallsetupcount = 0

    self.emptyspot1 = {}
    self.emptyspot2 = {}
    self.emptyspot3 = {}
    self.emptyspot4 = {}
    self.emptyspot5 = {}
	
    self.breakspot1 = {}
    self.breakspot2 = {}
    self.breakspot3 = {}
    self.breakspot4 = {}
    self.breakspot5 = {}
	
    self.pipisspot1 = {}
    self.pipisspot2 = {}
    self.pipisspot3 = {}
    self.pipisspot4 = {}
    self.pipisspot5 = {}
	
    self.redbreakspot1 = {}
    self.redbreakspot2 = {}
    self.redbreakspot3 = {}
    self.redbreakspot4 = {}
    self.redbreakspot5 = {}

    self.bombspot1 = {}
    self.bombspot2 = {}
    self.bombspot3 = {}
    self.bombspot4 = {}
    self.bombspot5 = {}

    self.wallcreatetimer = {}
    self.walltype = {}
end

function SNEOWall:createWall(spot_1, spot_2, spot_3, spot_4, spot_5, wall_time, wall_type)
    if spot_1 == 0 then
    end
    if spot_1 == 1 then
        self.emptyspot1[self.wallsetupcount] = 1
    end
    if spot_1 == 2 then
        self.breakspot1[self.wallsetupcount] = 1
    end
    if spot_1 == 3 then
        self.bombspot1[self.wallsetupcount] = 1
    end
    if spot_1 == 4 then
        self.redbreakspot1[self.wallsetupcount] = 1
    end
    if spot_1 == 5 then
        self.pipisspot1[self.wallsetupcount] = 1
    end
	
    if spot_2 == 0 then
    end
    if spot_2 == 1 then
        self.emptyspot2[self.wallsetupcount] = 2
    end
    if spot_2 == 2 then
        self.breakspot2[self.wallsetupcount] = 2
    end
    if spot_2 == 3 then
        self.bombspot2[self.wallsetupcount] = 2
    end
    if spot_2 == 4 then
        self.redbreakspot2[self.wallsetupcount] = 2
    end
    if spot_2 == 5 then
        self.pipisspot2[self.wallsetupcount] = 2
    end
	
    if spot_3 == 0 then
    end
    if spot_3 == 1 then
        self.emptyspot3[self.wallsetupcount] = 3
    end
    if spot_3 == 2 then
        self.breakspot3[self.wallsetupcount] = 3
    end
    if spot_3 == 3 then
        self.bombspot3[self.wallsetupcount] = 3
    end
    if spot_3 == 4 then
        self.redbreakspot3[self.wallsetupcount] = 3
    end
    if spot_3 == 5 then
        self.pipisspot3[self.wallsetupcount] = 3
    end
	
    if spot_4 == 0 then
    end
    if spot_4 == 1 then
        self.emptyspot4[self.wallsetupcount] = 4
    end
    if spot_4 == 2 then
        self.breakspot4[self.wallsetupcount] = 4
    end
    if spot_4 == 3 then
        self.bombspot4[self.wallsetupcount] = 4
    end
    if spot_4 == 4 then
        self.redbreakspot4[self.wallsetupcount] = 4
    end
    if spot_4 == 5 then
        self.pipisspot4[self.wallsetupcount] = 4
    end
	
    if spot_5 == 0 then
    end
    if spot_5 == 1 then
        self.emptyspot5[self.wallsetupcount] = 5
    end
    if spot_5 == 2 then
        self.breakspot5[self.wallsetupcount] = 5
    end
    if spot_5 == 3 then
        self.bombspot5[self.wallsetupcount] = 5
    end
    if spot_5 == 4 then
        self.redbreakspot5[self.wallsetupcount] = 5
    end
    if spot_5 == 5 then
        self.pipisspot5[self.wallsetupcount] = 5
    end
	
    self.wallcreatetimer[self.wallsetupcount] = wall_time
    self.walltype[self.wallsetupcount] = wall_type
    self.wallsetupcount = self.wallsetupcount + 1
end

return SNEOWall