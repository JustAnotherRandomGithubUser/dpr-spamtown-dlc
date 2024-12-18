local WallCarts, super = Class(Wave)

local emptyspot1 = {}
local emptyspot2 = {}
local emptyspot3 = {}
local emptyspot4 = {}
local emptyspot5 = {}
	
local breakspot1 = {}
local breakspot2 = {}
local breakspot3 = {}
local breakspot4 = {}
local breakspot5 = {}
	
local pipisspot1 = {}
local pipisspot2 = {}
local pipisspot3 = {}
local pipisspot4 = {}
local pipisspot5 = {}
	
local redbreakspot1 = {}
local redbreakspot2 = {}
local redbreakspot3 = {}
local redbreakspot4 = {}
local redbreakspot5 = {}

local bombspot1 = {}
local bombspot2 = {}
local bombspot3 = {}
local bombspot4 = {}
local bombspot5 = {}
	
local wallsetupcount = 0
local wallcreatetimer = {}
local walltype = {}

local function sneoWallCreate(spot_1, spot_2, spot_3, spot_4, spot_5, wall_time, wall_type)
    if spot_1 == 0 then
    end
    if spot_1 == 1 then
        emptyspot1[wallsetupcount] = 1
    end
    if spot_1 == 2 then
        breakspot1[wallsetupcount] = 1
    end
    if spot_1 == 3 then
        bombspot1[wallsetupcount] = 1
    end
    if spot_1 == 4 then
        redbreakspot1[wallsetupcount] = 1
    end
    if spot_1 == 5 then
        pipisspot1[wallsetupcount] = 1
    end
	
    if spot_2 == 0 then
    end
    if spot_2 == 1 then
        emptyspot2[wallsetupcount] = 2
    end
    if spot_2 == 2 then
        breakspot2[wallsetupcount] = 2
    end
    if spot_2 == 3 then
        bombspot2[wallsetupcount] = 2
    end
    if spot_2 == 4 then
        redbreakspot2[wallsetupcount] = 2
    end
    if spot_2 == 5 then
        pipisspot2[wallsetupcount] = 2
    end
	
    if spot_3 == 0 then
    end
    if spot_3 == 1 then
        emptyspot3[wallsetupcount] = 3
    end
    if spot_3 == 2 then
        breakspot3[wallsetupcount] = 3
    end
    if spot_3 == 3 then
        bombspot3[wallsetupcount] = 3
    end
    if spot_3 == 4 then
        redbreakspot3[wallsetupcount] = 3
    end
    if spot_3 == 5 then
        pipisspot3[wallsetupcount] = 3
    end
	
    if spot_4 == 0 then
    end
    if spot_4 == 1 then
        emptyspot4[wallsetupcount] = 4
    end
    if spot_4 == 2 then
        breakspot4[wallsetupcount] = 4
    end
    if spot_4 == 3 then
        bombspot4[wallsetupcount] = 4
    end
    if spot_4 == 4 then
        redbreakspot4[wallsetupcount] = 4
    end
    if spot_4 == 5 then
        pipisspot4[wallsetupcount] = 4
    end
	
    if spot_5 == 0 then
    end
    if spot_5 == 1 then
        emptyspot5[wallsetupcount] = 5
    end
    if spot_5 == 2 then
        breakspot5[wallsetupcount] = 5
    end
    if spot_5 == 3 then
        bombspot5[wallsetupcount] = 5
    end
    if spot_5 == 4 then
        redbreakspot5[wallsetupcount] = 5
    end
    if spot_5 == 5 then
        pipisspot5[wallsetupcount] = 5
    end
	
    wallcreatetimer[wallsetupcount] = wall_time
    walltype[wallsetupcount] = wall_type
    wallsetupcount = wallsetupcount + DTMULT
end

function WallCarts:init()
	super.init(self)
	
    self.time = 11
	
    self:setArenaPosition(304, 172)
    self:setArenaSize(244, 164)
	
    self.wallsize = 7
    self.wallcountmax = 35
    self.wallcount = 0
    self.wallsetupcount = 0
    self.wallcreatetimermax = 30
	
    self.timer = 0
    self.difficulty = math.floor(Utils.random(0, 2))
    self.rand = 0
	
    self.track1_x = self.x
    self.track2_x = self.x + 320
    self.track3_x = self.x + 640
	
    self.debug_font = Assets.getFont("main")
	
    breakspot1[self.wallcountmax] = -1
    breakspot2[self.wallcountmax] = -1
    breakspot3[self.wallcountmax] = -1
    breakspot4[self.wallcountmax] = -1
    breakspot5[self.wallcountmax] = -1
	
    pipisspot1[self.wallcountmax] = -1
    pipisspot2[self.wallcountmax] = -1
    pipisspot3[self.wallcountmax] = -1
    pipisspot4[self.wallcountmax] = -1
    pipisspot5[self.wallcountmax] = -1
	
    emptyspot1[self.wallcountmax] = -1
    emptyspot2[self.wallcountmax] = -1
    emptyspot3[self.wallcountmax] = -1
    emptyspot4[self.wallcountmax] = -1
    emptyspot5[self.wallcountmax] = -1
	
    redbreakspot1[self.wallcountmax] = -1
    redbreakspot2[self.wallcountmax] = -1
    redbreakspot3[self.wallcountmax] = -1
    redbreakspot4[self.wallcountmax] = -1
    redbreakspot5[self.wallcountmax] = -1
	
    bombspot1[self.wallcountmax] = -1
    bombspot2[self.wallcountmax] = -1
    bombspot3[self.wallcountmax] = -1
    bombspot4[self.wallcountmax] = -1
    bombspot5[self.wallcountmax] = -1
	
    self.wallspeed = {}
    self.walltype = {}

    self.a = 0
    for i = 1,self.wallcountmax do
       self.wallspeed[self.a] = -7
       self.a = self.a + 1
    end

    self.a = 0
    for i = 1,self.wallcountmax do
       self.walltype[self.a] = 0
       self.a = self.a + 1
    end
		
    if self.difficulty == 0 then
        self.a = 0
        for i = 1,self.wallcountmax do
            self.walltype[self.a] = 1
            self.a = self.a + 1
        end
    end   
	if self.difficulty == 1 then
        self.a = 0
        for i = 1,self.wallcountmax do
            self.walltype[self.a] = 1
            self.a = self.a + 1
        end
    end	
end

function WallCarts:update()
    super.update(self)
	
    --brace yourselves, this part is pretty fuckin' long lmao.
    if self.difficulty == 0 then		
        self.rand = math.floor(Utils.random(1, 3))
        if self.rand == 1 then
            sneoWallCreate(0, 0, 0, 2, 0, 1, 1)
            sneoWallCreate(0, 2, 3, 0, 0, 30, 1)
            sneoWallCreate(0, 3, 0, 2, 0, 30, 1)
        end
        if self.rand == 2 then
            sneoWallCreate(0, 2, 0, 3, 0, 1, 1)
            sneoWallCreate(0, 3, 0, 2, 0, 30, 1)
            sneoWallCreate(0, 2, 0, 3, 0, 30, 1)
        end
        if self.rand == 3 then
            sneoWallCreate(0, 0, 0, 0, 2, 1, 1)
            sneoWallCreate(0, 3, 2, 0, 0, 30, 1)
            sneoWallCreate(0, 2, 3, 0, 0, 30, 1)
        end
		
        self.rand = math.floor(Utils.random(1, 3))
        if self.rand == 1 then
            sneoWallCreate(0, 1, 1, 0, 0, 40, 1)
            sneoWallCreate(0, 2, 2, 0, 0, 6, 1)
            sneoWallCreate(0, 2, 2, 0, 0, 6, 1)
            sneoWallCreate(0, 2, 2, 0, 0, 6, 1)
        end
        if self.rand == 2 then
            sneoWallCreate(0, 0, 0, 1, 1, 40, 1)
            sneoWallCreate(0, 0, 0, 2, 2, 6, 1)
            sneoWallCreate(0, 0, 0, 2, 2, 6, 1)
            sneoWallCreate(0, 0, 0, 2, 2, 6, 1)
        end
        if self.rand == 3 then
            sneoWallCreate(0, 0, 1, 1, 0, 40, 1)
            sneoWallCreate(0, 0, 2, 1, 0, 6, 1)
            sneoWallCreate(0, 0, 2, 2, 0, 6, 1)
            sneoWallCreate(0, 0, 2, 2, 0, 6, 1)
        end
        if self.rand == 1 then
            sneoWallCreate(0, 0, 0, 0, 2, 30, 1)
            sneoWallCreate(0, 2, 0, 0, 0, 30, 1)
            sneoWallCreate(0, 3, 0, 2, 0, 30, 1)
        end
        if self.rand == 2 then
            sneoWallCreate(0, 2, 0, 0, 0, 30, 1)
            sneoWallCreate(0, 0, 0, 2, 0, 30, 1)
            sneoWallCreate(0, 2, 0, 3, 0, 30, 1)
        end
        if self.rand == 3 then
            sneoWallCreate(2, 0, 0, 0, 0, 30, 1)
            sneoWallCreate(0, 0, 2, 0, 0, 30, 1)
            sneoWallCreate(0, 2, 3, 0, 0, 30, 1)
        end
		
        self.rand = math.floor(Utils.random(1, 3))
        if self.rand == 1 then
            sneoWallCreate(0, 1, 1, 0, 0, 40, 1)
            sneoWallCreate(0, 2, 2, 0, 0, 6, 1)
            sneoWallCreate(0, 2, 2, 0, 0, 6, 1)
            sneoWallCreate(0, 2, 2, 0, 0, 6, 1)
        end
        if self.rand == 2 then
            sneoWallCreate(0, 1, 1, 0, 0, 40, 1)
            sneoWallCreate(0, 2, 2, 0, 0, 6, 1)
            sneoWallCreate(0, 2, 2, 0, 0, 6, 1)
            sneoWallCreate(0, 2, 2, 0, 0, 6, 1)
        end
        if self.rand == 3 then
            sneoWallCreate(0, 1, 1, 0, 0, 40, 1)
            sneoWallCreate(0, 2, 2, 0, 0, 6, 1)
            sneoWallCreate(0, 2, 2, 0, 0, 6, 1)
            sneoWallCreate(0, 2, 2, 0, 0, 6, 1)
        end
		
        sneoWallCreate(1, 1, 1, 1, 1, 9999, 0)
    end   
	if self.difficulty == 1 then
        self.rand = math.floor(Utils.random(1, 4))
        if self.rand == 1 then
            sneoWallCreate(3, 0, 0, 2, 0, 1, 1)
            sneoWallCreate(0, 2, 3, 0, 0, 20, 1)
            sneoWallCreate(0, 3, 0, 2, 0, 20, 1)
        end
        if self.rand == 2 then
            sneoWallCreate(0, 2, 0, 3, 0, 1, 1)
            sneoWallCreate(0, 3, 0, 2, 0, 20, 1)
            sneoWallCreate(0, 2, 0, 3, 0, 20, 1)
        end
        if self.rand == 3 then
            sneoWallCreate(0, 0, 0, 3, 2, 1, 1)
            sneoWallCreate(0, 3, 2, 0, 0, 20, 1)
            sneoWallCreate(0, 2, 3, 0, 0, 20, 1)
        end
        if self.rand == 4 then
            sneoWallCreate(2, 3, 0, 0, 0, 1, 1)
            sneoWallCreate(0, 0, 2, 3, 0, 20, 1)
            sneoWallCreate(0, 0, 3, 2, 0, 20, 1)
        end

        self.rand = math.floor(Utils.random(1, 4))
        if self.rand == 1 then
            sneoWallCreate(3, 0, 0, 2, 0, 20, 1)
            sneoWallCreate(0, 2, 3, 0, 0, 20, 1)
            sneoWallCreate(0, 3, 0, 2, 0, 20, 1)
        end
        if self.rand == 2 then
             sneoWallCreate(0, 2, 0, 3, 0, 20, 1)
             sneoWallCreate(0, 3, 0, 2, 0, 20, 1)
             sneoWallCreate(0, 2, 0, 3, 0, 20, 1)
        end
        if self.rand == 3 then
             sneoWallCreate(0, 0, 0, 3, 2, 20, 1)
             sneoWallCreate(0, 3, 2, 0, 0, 20, 1)
             sneoWallCreate(0, 2, 3, 0, 0, 20, 1)
        end
        if self.rand == 4 then
             sneoWallCreate(2, 3, 0, 0, 0, 20, 1)
             sneoWallCreate(0, 0, 2, 3, 0, 20, 1)
             sneoWallCreate(0, 0, 3, 2, 0, 20, 1)
        end
        if self.rand == 1 then
             sneoWallCreate(0, 1, 1, 0, 0, 32, 1)
             sneoWallCreate(0, 2, 2, 0, 0, 6, 1)
             sneoWallCreate(0, 2, 2, 0, 0, 6, 1)
             sneoWallCreate(0, 2, 2, 0, 0, 6, 1)
        end
        if self.rand == 2 then
             sneoWallCreate(0, 0, 0, 1, 1, 32, 1)
             sneoWallCreate(0, 0, 0, 2, 2, 6, 1)
             sneoWallCreate(0, 0, 0, 2, 2, 6, 1)
             sneoWallCreate(0, 0, 0, 2, 2, 6, 1)
        end
        if self.rand == 3 then
             sneoWallCreate(0, 0, 1, 1, 0, 32, 1)
             sneoWallCreate(0, 0, 2, 2, 0, 6, 1)
             sneoWallCreate(0, 0, 2, 2, 0, 6, 1)
             sneoWallCreate(0, 0, 2, 2, 0, 6, 1)
        end
        if self.rand == 4 then
             sneoWallCreate(1, 1, 0, 0, 0, 32, 1)
             sneoWallCreate(2, 2, 0, 0, 0, 6, 1)
             sneoWallCreate(2, 2, 0, 0, 0, 6, 1)
             sneoWallCreate(2, 2, 0, 0, 0, 6, 1)
        end
        if self.rand == 1 then
             sneoWallCreate(0, 0, 0, 0, 2, 20, 1)
             sneoWallCreate(0, 2, 0, 0, 0, 20, 1)
             sneoWallCreate(0, 3, 0, 2, 0, 20, 1)
        end
        if self.rand == 2 then
             sneoWallCreate(0, 2, 0, 0, 0, 20, 1)
             sneoWallCreate(0, 0, 0, 2, 0, 20, 1)
             sneoWallCreate(0, 2, 0, 3, 0, 20, 1)
        end
        if self.rand == 3 then
             sneoWallCreate(2, 0, 0, 0, 0, 20, 1)
             sneoWallCreate(0, 2, 0, 0, 0, 20, 1)
             sneoWallCreate(0, 2, 3, 0, 0, 20, 1)
        end
        if self.rand == 4 then
             sneoWallCreate(0, 0, 0, 2, 0, 20, 1)
             sneoWallCreate(2, 0, 0, 0, 0, 20, 1)
             sneoWallCreate(0, 0, 3, 2, 0, 20, 1)
        end

        self.rand = math.floor(Utils.random(1, 4))
        if self.rand == 1 then
             sneoWallCreate(3, 0, 0, 2, 0, 20, 1)
             sneoWallCreate(0, 2, 3, 0, 0, 20, 1)
             sneoWallCreate(0, 3, 0, 2, 0, 20, 1)
        end
        if self.rand == 2 then
             sneoWallCreate(0, 2, 0, 3, 0, 20, 1)
             sneoWallCreate(0, 3, 0, 2, 0, 20, 1)
             sneoWallCreate(0, 2, 0, 3, 0, 20, 1)
        end
        if self.rand == 3 then
             sneoWallCreate(0, 0, 0, 3, 2, 20, 1)
             sneoWallCreate(0, 3, 2, 0, 0, 20, 1)
             sneoWallCreate(0, 2, 3, 0, 0, 20, 1)
        end
        if self.rand == 4 then
             sneoWallCreate(2, 3, 0, 0, 0, 20, 1)
             sneoWallCreate(0, 0, 2, 3, 0, 20, 1)
             sneoWallCreate(0, 0, 3, 2, 0, 20, 1)
        end

        sneoWallCreate(1, 1, 1, 1, 1, 9999, 0)
    end	
	if self.difficulty == 2 then
        for i = 0, 6-1 do
            sneoWallCreate(
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  7, 
			  0
            )
            sneoWallCreate(
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  7, 
			  0
            )
        end
        for i = 0, 5-1 do
            sneoWallCreate(
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  63, 
			  0
            )
            sneoWallCreate(
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  63, 
			  0
            )
        end
        for i = 0, 5-1 do
            sneoWallCreate(
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  7, 
			  0
            )
            sneoWallCreate(
			  0, 
			  0, 
			  0, 
			  0, 
			  0, 
			  9999, 
			  0
            )
        end
    end
	if self.difficulty == 3 then
        for i = 0, 6-1 do
            sneoWallCreate(
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  7, 
			  0
            )
            sneoWallCreate(
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  63, 
			  0
            )
        end
        for i = 0, 5-1 do
            sneoWallCreate(
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  7, 
			  0
            )
            sneoWallCreate(
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  63, 
			  0
            )
        end
        for i = 0, 5-1 do
            sneoWallCreate(
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 3, 0},  
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  7, 
			  0
            )
            sneoWallCreate(
			  0, 
			  0, 
			  0, 
			  0, 
			  0, 
			  9999, 
			  0
            )
        end
    end
	if self.difficulty == 99 then
        if self.timer == 0 then
            self.rand = math.floor(Utils.random(1, 2))
        end
        if self.rand == 1 then
            sneoWallCreate(0, 0, 0, 0, 4, 1, 1)
            sneoWallCreate(1, 0, 0, 0, 0, 7, 1)
        end
        if self.rand == 2 then
            sneoWallCreate(4, 0, 0, 0, 0, 1, 1)
            sneoWallCreate(0, 0, 0, 0, 1, 7, 1)
        end
		
        if self.timer == 0 then
            self.rand = math.floor(Utils.random(1, 3))
        end
        if self.rand == 1 then
            sneoWallCreate(4, 0, 0, 0, 3, 63, 1)
        end
        if self.rand == 2 then
            sneoWallCreate(3, 0, 0, 0, 4, 63, 1)
        end
        if self.rand == 3 then
            sneoWallCreate(0, 3, 4, 0, 0, 63, 1)
        end
		
        sneoWallCreate(0, 0, 1, 0, 4, 60, 0)
        sneoWallCreate(4, 2, 1, 0, 0, 7, 0)
        sneoWallCreate(0, 2, 3, 1, 0, 7, 0)
        sneoWallCreate(0, 2, 3, 1, 0, 7, 0)
        sneoWallCreate(0, 4, 1, 3, 1, 50, 0)
        sneoWallCreate(3, 1, 1, 4, 2, 7, 0)
        sneoWallCreate(3, 4, 0, 3, 1, 7, 0)
        sneoWallCreate(2, 1, 0, 1, 2, 7, 0)
        sneoWallCreate(2, 4, 2, 0, 4, 7, 0)
        sneoWallCreate(2, 1, 2, 0, 0, 7, 0)
        sneoWallCreate(1, 4, 2, 0, 3, 50, 0)
        sneoWallCreate(4, 2, 0, 0, 2, 7, 0)
        sneoWallCreate(0, 2, 1, 1, 1, 7, 0)
        sneoWallCreate(3, 1, 2, 1, 3, 7, 0)
        sneoWallCreate(1, 1, 4, 0, 0, 7, 0)
        sneoWallCreate(4, 2, 2, 0, 1, 7, 0)
        sneoWallCreate(3, 2, 3, 4, 2, 50, 0)
        sneoWallCreate(2, 2, 1, 2, 4, 7, 0)
        sneoWallCreate(3, 1, 1, 1, 4, 7, 0)
        sneoWallCreate(2, 2, 1, 1, 3, 7, 0)
        sneoWallCreate(3, 4, 1, 1, 1, 7, 0)
        sneoWallCreate(3, 0, 0, 4, 2, 7, 0)
        sneoWallCreate(0, 0, 0, 0, 0, 9999, 0)
    end

    self.timer = self.timer + DTMULT
	
    if self.wallcount < self.wallcountmax and self.timer == wallcreatetimer[self.wallcount] then
        for i = 0, self.wallsize-1 do
            if i == 0 or i == (self.wallsize - 1) then
                local bullet = self:spawnBullet("sneo/wallbullet_new", SCREEN_WIDTH, (SCREEN_HEIGHT/2 + i * 34 - 172))
                bullet:setSprite("battle/bullets/sneo/wall_box")
                bullet.scale_x = 1.25
                bullet.scale_y = 1.6
                bullet.destroyable = false
                bullet:setColor(COLORS.white)
                bullet.wallnumber = self.wallcount
				
                if i == 0 then
                    bullet.wallcontroller = 1
                end
				
                if i == (self.wallsize - 1) then
                    local bullet = self:spawnBullet("sneo/wallbullet_new", SCREEN_WIDTH - 25/2, ((SCREEN_HEIGHT/2 + 20) + i * 34 - 180))
                    bullet:setSprite("battle/bullets/sneo/wall_car")
                    bullet.scale_x = 1.25
                    bullet.scale_y = 1.6
                    bullet.destroyable = false
                    bullet:setColor(COLORS.white)
                    bullet.layer = self.layer - 1
                    bullet.wallnumber = self.wallcount
                end
            elseif emptyspot1[self.wallcount] == i or emptyspot2[self.wallcount] == i or emptyspot3[self.wallcount] == i or emptyspot4[self.wallcount] == i or emptyspot5[self.wallcount] == i then
            
			elseif bombspot1[self.wallcount] == i or bombspot2[self.wallcount] == i or bombspot3[self.wallcount] == i or bombspot4[self.wallcount] == i or bombspot5[self.wallcount] == i then
                local bullet = self:spawnBullet("sneo/wall_bomb", SCREEN_WIDTH, (SCREEN_HEIGHT/2 + i * 34 - 170))
                bullet.wallnumber = self.wallcount
			elseif pipisspot1[self.wallcount] == i or pipisspot2[self.wallcount] == i or pipisspot3[self.wallcount] == i or pipisspot4[self.wallcount] == i or pipisspot5[self.wallcount] == i then
                bullet = self:spawnBullet("sneo/wall_pipis", SCREEN_WIDTH, (SCREEN_HEIGHT/2 + i * 34 - 170))
                bullet.wallnumber = self.wallcount
            else
                local bullet = self:spawnBullet("sneo/wallbullet_new", SCREEN_WIDTH, (SCREEN_HEIGHT/2 + i * 34 - 172))
                bullet:setSprite("battle/bullets/sneo/mail_1")
                bullet.scale_x = 1.2
                bullet.scale_y = 1.71
                bullet.destroyable = false
                bullet.wallnumber = self.wallcount
				
                if breakspot1[self.wallcount] == i or breakspot2[self.wallcount] == i or breakspot3[self.wallcount] == i or breakspot4[self.wallcount] == i or breakspot5[self.wallcount] == i then
                    bullet.destroyable = true
                    bullet:setSprite("battle/bullets/sneo/lilguy")
                    bullet.sprite:play(0.25, true)
                    bullet.scale_y = 1.2
                elseif redbreakspot1[self.wallcount] == i or redbreakspot2[self.wallcount] == i or redbreakspot3[self.wallcount] == i or redbreakspot4[self.wallcount] == i or redbreakspot5[self.wallcount] == i then
                    bullet.destroyable = true
                    bullet.red = true
                    bullet:setSprite("battle/bullets/sneo/lilguy")
                    bullet.sprite:play(0.25, true)
                    bullet.scale_y = 1.2
                    bullet:setColor(COLORS.red)
                else
                    bullet:setColor(COLORS.white)
                end
            end
        end  
        self.timer = 0
        self.wallcount = self.wallcount + 1
    end
end

function WallCarts:draw()
    super.draw(self)
	
    self.track1_x = self.track1_x + 4 * DTMULT
    self.track2_x = self.track2_x + 4 * DTMULT
    self.track3_x = self.track3_x + 4 * DTMULT

    if self.track1_x > SCREEN_WIDTH then
        self.track1_x = self.track1_x - 960
    end
    if self.track2_x > SCREEN_WIDTH then
        self.track2_x = self.track2_x - 960
    end
    if self.track3_x > SCREEN_WIDTH then
        self.track3_x = self.track3_x - 960
    end
    Draw.draw(Assets.getTexture("battle/bullets/sneo/wall_track"), self.track1_x, (SCREEN_HEIGHT - 180), 0, 1, 1)
    Draw.draw(Assets.getTexture("battle/bullets/sneo/wall_track"), self.track2_x, (SCREEN_HEIGHT - 180), 0, 1, 1)
    Draw.draw(Assets.getTexture("battle/bullets/sneo/wall_track"), self.track3_x, (SCREEN_HEIGHT - 180), 0, 1, 1)
	
    if self.debug_render then
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.setFont(self.debug_font)
		
        local dbg1 = string.format(
            [[difficulty = %d
wallsetupcount = %d
wallcountmax = %d
wallcreatetimermax = %d
            ]],
            self.difficulty,  
            wallsetupcount,
            self.wallcountmax,
            self.wallcreatetimermax
        )
        local dbg2 = string.format(
            [[a = %d
random_pattern = $d
            ]],
            self.a,
            self.rand
        )

        love.graphics.printf("--WALLCARTS DEBUG--", 10, 380, SCREEN_WIDTH*2, "left", 0, 0.5, 0.5)
        love.graphics.printf(dbg1, 10, 400, SCREEN_WIDTH*2, "left", 0, 0.5, 0.5)
        love.graphics.printf(dbg2, 180, 400, SCREEN_WIDTH*2, "left", 0, 0.5, 0.5)
    end
end

function WallCarts:onStart()
	Game.battle:swapSoul(YellowSoul())
    self.debug_render = true
end

function WallCarts:onEnd()
    self.debug_render = false
end

return WallCarts