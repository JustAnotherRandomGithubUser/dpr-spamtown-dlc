local WallCarts, super = Class(Wave)

function WallCarts:init()
	super.init(self)
	
    self.time = 11
	
    self:setArenaPosition(304, 172)
    self:setArenaSize(244, 164)
	
    self.sneo_wall = self:addChild(SNEOWall())
	
    self.wallsize = 7
    self.wallcountmax = 35
    self.wallcount = 0
    self.wallsetupcount = 0
    self.wallcreatetimermax = 30

    self.difficulty = Utils.pick({0, 1, 2, 3})
    self.rand = 0
	
    self.wave_timer = 0
	
    self.track1_x = self.x
    self.track2_x = self.x + 320
    self.track3_x = self.x + 640
	
    self.debug_font = Assets.getFont("main")
	
    self.sneo_wall.breakspot1[self.wallcountmax] = -1
    self.sneo_wall.breakspot2[self.wallcountmax] = -1
    self.sneo_wall.breakspot3[self.wallcountmax] = -1
    self.sneo_wall.breakspot4[self.wallcountmax] = -1
    self.sneo_wall.breakspot5[self.wallcountmax] = -1
	
    self.sneo_wall.pipisspot1[self.wallcountmax] = -1
    self.sneo_wall.pipisspot2[self.wallcountmax] = -1
    self.sneo_wall.pipisspot3[self.wallcountmax] = -1
    self.sneo_wall.pipisspot4[self.wallcountmax] = -1
    self.sneo_wall.pipisspot5[self.wallcountmax] = -1
	
    self.sneo_wall.emptyspot1[self.wallcountmax] = -1
    self.sneo_wall.emptyspot2[self.wallcountmax] = -1
    self.sneo_wall.emptyspot3[self.wallcountmax] = -1
    self.sneo_wall.emptyspot4[self.wallcountmax] = -1
    self.sneo_wall.emptyspot5[self.wallcountmax] = -1
	
    self.sneo_wall.redbreakspot1[self.wallcountmax] = -1
    self.sneo_wall.redbreakspot2[self.wallcountmax] = -1
    self.sneo_wall.redbreakspot3[self.wallcountmax] = -1
    self.sneo_wall.redbreakspot4[self.wallcountmax] = -1
    self.sneo_wall.redbreakspot5[self.wallcountmax] = -1
	
    self.sneo_wall.bombspot1[self.wallcountmax] = -1
    self.sneo_wall.bombspot2[self.wallcountmax] = -1
    self.sneo_wall.bombspot3[self.wallcountmax] = -1
    self.sneo_wall.bombspot4[self.wallcountmax] = -1
    self.sneo_wall.bombspot5[self.wallcountmax] = -1
	
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
 
    --brace yourselves, this part is pretty fuckin' long lmao.
    if self.difficulty == 0 then		
        self.a = 0
        for i = 1,self.wallcountmax do
            self.walltype[self.a] = 1
            self.a = self.a + 1
        end
	
        self.rand = math.floor(Utils.random(1, 3))
        if self.rand == 1 then
            self.sneo_wall:createWall(0, 0, 0, 2, 0, 1, 1)
            self.sneo_wall:createWall(0, 2, 3, 0, 0, 30, 1)
            self.sneo_wall:createWall(0, 3, 0, 2, 0, 30, 1)
        end
        if self.rand == 2 then
            self.sneo_wall:createWall(0, 2, 0, 3, 0, 1, 1)
            self.sneo_wall:createWall(0, 3, 0, 2, 0, 30, 1)
            self.sneo_wall:createWall(0, 2, 0, 3, 0, 30, 1)
        end
        if self.rand == 3 then
            self.sneo_wall:createWall(0, 0, 0, 0, 2, 1, 1)
            self.sneo_wall:createWall(0, 3, 2, 0, 0, 30, 1)
            self.sneo_wall:createWall(0, 2, 3, 0, 0, 30, 1)
        end
		
        self.rand = math.floor(Utils.random(1, 3))
        if self.rand == 1 then
            self.sneo_wall:createWall(0, 1, 1, 0, 0, 40, 1)
            self.sneo_wall:createWall(0, 2, 2, 0, 0, 6, 1)
            self.sneo_wall:createWall(0, 2, 2, 0, 0, 6, 1)
            self.sneo_wall:createWall(0, 2, 2, 0, 0, 6, 1)
        end
        if self.rand == 2 then
            self.sneo_wall:createWall(0, 0, 0, 1, 1, 40, 1)
            self.sneo_wall:createWall(0, 0, 0, 2, 2, 6, 1)
            self.sneo_wall:createWall(0, 0, 0, 2, 2, 6, 1)
            self.sneo_wall:createWall(0, 0, 0, 2, 2, 6, 1)
        end
        if self.rand == 3 then
            self.sneo_wall:createWall(0, 0, 1, 1, 0, 40, 1)
            self.sneo_wall:createWall(0, 0, 2, 1, 0, 6, 1)
            self.sneo_wall:createWall(0, 0, 2, 2, 0, 6, 1)
            self.sneo_wall:createWall(0, 0, 2, 2, 0, 6, 1)
        end
        if self.rand == 1 then
            self.sneo_wall:createWall(0, 0, 0, 0, 2, 30, 1)
            self.sneo_wall:createWall(0, 2, 0, 0, 0, 30, 1)
            self.sneo_wall:createWall(0, 3, 0, 2, 0, 30, 1)
        end
        if self.rand == 2 then
            self.sneo_wall:createWall(0, 2, 0, 0, 0, 30, 1)
            self.sneo_wall:createWall(0, 0, 0, 2, 0, 30, 1)
            self.sneo_wall:createWall(0, 2, 0, 3, 0, 30, 1)
        end
        if self.rand == 3 then
            self.sneo_wall:createWall(2, 0, 0, 0, 0, 30, 1)
            self.sneo_wall:createWall(0, 0, 2, 0, 0, 30, 1)
            self.sneo_wall:createWall(0, 2, 3, 0, 0, 30, 1)
        end
		
        self.rand = math.floor(Utils.random(1, 3))
        if self.rand == 1 then
            self.sneo_wall:createWall(0, 1, 1, 0, 0, 40, 1)
            self.sneo_wall:createWall(0, 2, 2, 0, 0, 6, 1)
            self.sneo_wall:createWall(0, 2, 2, 0, 0, 6, 1)
            self.sneo_wall:createWall(0, 2, 2, 0, 0, 6, 1)
        end
        if self.rand == 2 then
            self.sneo_wall:createWall(0, 1, 1, 0, 0, 40, 1)
            self.sneo_wall:createWall(0, 2, 2, 0, 0, 6, 1)
            self.sneo_wall:createWall(0, 2, 2, 0, 0, 6, 1)
            self.sneo_wall:createWall(0, 2, 2, 0, 0, 6, 1)
        end
        if self.rand == 3 then
            self.sneo_wall:createWall(0, 1, 1, 0, 0, 40, 1)
            self.sneo_wall:createWall(0, 2, 2, 0, 0, 6, 1)
            self.sneo_wall:createWall(0, 2, 2, 0, 0, 6, 1)
            self.sneo_wall:createWall(0, 2, 2, 0, 0, 6, 1)
        end
		
        self.sneo_wall:createWall(1, 1, 1, 1, 1, 9999, 0)
    end   
	if self.difficulty == 1 then
        self.a = 0
        for i = 1,self.wallcountmax do
            self.walltype[self.a] = 1
            self.a = self.a + 1
        end
	
        self.rand = math.floor(Utils.random(1, 4))
        if self.rand == 1 then
            self.sneo_wall:createWall(3, 0, 0, 2, 0, 1, 1)
            self.sneo_wall:createWall(0, 2, 3, 0, 0, 20, 1)
            self.sneo_wall:createWall(0, 3, 0, 2, 0, 20, 1)
        end
        if self.rand == 2 then
            self.sneo_wall:createWall(0, 2, 0, 3, 0, 1, 1)
            self.sneo_wall:createWall(0, 3, 0, 2, 0, 20, 1)
            self.sneo_wall:createWall(0, 2, 0, 3, 0, 20, 1)
        end
        if self.rand == 3 then
            self.sneo_wall:createWall(0, 0, 0, 3, 2, 1, 1)
            self.sneo_wall:createWall(0, 3, 2, 0, 0, 20, 1)
            self.sneo_wall:createWall(0, 2, 3, 0, 0, 20, 1)
        end
        if self.rand == 4 then
            self.sneo_wall:createWall(2, 3, 0, 0, 0, 1, 1)
            self.sneo_wall:createWall(0, 0, 2, 3, 0, 20, 1)
            self.sneo_wall:createWall(0, 0, 3, 2, 0, 20, 1)
        end

        self.rand = math.floor(Utils.random(1, 4))
        if self.rand == 1 then
            self.sneo_wall:createWall(3, 0, 0, 2, 0, 20, 1)
            self.sneo_wall:createWall(0, 2, 3, 0, 0, 20, 1)
            self.sneo_wall:createWall(0, 3, 0, 2, 0, 20, 1)
        end
        if self.rand == 2 then
             self.sneo_wall:createWall(0, 2, 0, 3, 0, 20, 1)
             self.sneo_wall:createWall(0, 3, 0, 2, 0, 20, 1)
             self.sneo_wall:createWall(0, 2, 0, 3, 0, 20, 1)
        end
        if self.rand == 3 then
             self.sneo_wall:createWall(0, 0, 0, 3, 2, 20, 1)
             self.sneo_wall:createWall(0, 3, 2, 0, 0, 20, 1)
             self.sneo_wall:createWall(0, 2, 3, 0, 0, 20, 1)
        end
        if self.rand == 4 then
             self.sneo_wall:createWall(2, 3, 0, 0, 0, 20, 1)
             self.sneo_wall:createWall(0, 0, 2, 3, 0, 20, 1)
             self.sneo_wall:createWall(0, 0, 3, 2, 0, 20, 1)
        end
        if self.rand == 1 then
             self.sneo_wall:createWall(0, 1, 1, 0, 0, 32, 1)
             self.sneo_wall:createWall(0, 2, 2, 0, 0, 6, 1)
             self.sneo_wall:createWall(0, 2, 2, 0, 0, 6, 1)
             self.sneo_wall:createWall(0, 2, 2, 0, 0, 6, 1)
        end
        if self.rand == 2 then
             self.sneo_wall:createWall(0, 0, 0, 1, 1, 32, 1)
             self.sneo_wall:createWall(0, 0, 0, 2, 2, 6, 1)
             self.sneo_wall:createWall(0, 0, 0, 2, 2, 6, 1)
             self.sneo_wall:createWall(0, 0, 0, 2, 2, 6, 1)
        end
        if self.rand == 3 then
             self.sneo_wall:createWall(0, 0, 1, 1, 0, 32, 1)
             self.sneo_wall:createWall(0, 0, 2, 2, 0, 6, 1)
             self.sneo_wall:createWall(0, 0, 2, 2, 0, 6, 1)
             self.sneo_wall:createWall(0, 0, 2, 2, 0, 6, 1)
        end
        if self.rand == 4 then
             self.sneo_wall:createWall(1, 1, 0, 0, 0, 32, 1)
             self.sneo_wall:createWall(2, 2, 0, 0, 0, 6, 1)
             self.sneo_wall:createWall(2, 2, 0, 0, 0, 6, 1)
             self.sneo_wall:createWall(2, 2, 0, 0, 0, 6, 1)
        end
        if self.rand == 1 then
             self.sneo_wall:createWall(0, 0, 0, 0, 2, 20, 1)
             self.sneo_wall:createWall(0, 2, 0, 0, 0, 20, 1)
             self.sneo_wall:createWall(0, 3, 0, 2, 0, 20, 1)
        end
        if self.rand == 2 then
             self.sneo_wall:createWall(0, 2, 0, 0, 0, 20, 1)
             self.sneo_wall:createWall(0, 0, 0, 2, 0, 20, 1)
             self.sneo_wall:createWall(0, 2, 0, 3, 0, 20, 1)
        end
        if self.rand == 3 then
             self.sneo_wall:createWall(2, 0, 0, 0, 0, 20, 1)
             self.sneo_wall:createWall(0, 2, 0, 0, 0, 20, 1)
             self.sneo_wall:createWall(0, 2, 3, 0, 0, 20, 1)
        end
        if self.rand == 4 then
             self.sneo_wall:createWall(0, 0, 0, 2, 0, 20, 1)
             self.sneo_wall:createWall(2, 0, 0, 0, 0, 20, 1)
             self.sneo_wall:createWall(0, 0, 3, 2, 0, 20, 1)
        end

        self.rand = math.floor(Utils.random(1, 4))
        if self.rand == 1 then
             self.sneo_wall:createWall(3, 0, 0, 2, 0, 20, 1)
             self.sneo_wall:createWall(0, 2, 3, 0, 0, 20, 1)
             self.sneo_wall:createWall(0, 3, 0, 2, 0, 20, 1)
        end
        if self.rand == 2 then
             self.sneo_wall:createWall(0, 2, 0, 3, 0, 20, 1)
             self.sneo_wall:createWall(0, 3, 0, 2, 0, 20, 1)
             self.sneo_wall:createWall(0, 2, 0, 3, 0, 20, 1)
        end
        if self.rand == 3 then
             self.sneo_wall:createWall(0, 0, 0, 3, 2, 20, 1)
             self.sneo_wall:createWall(0, 3, 2, 0, 0, 20, 1)
             self.sneo_wall:createWall(0, 2, 3, 0, 0, 20, 1)
        end
        if self.rand == 4 then
             self.sneo_wall:createWall(2, 3, 0, 0, 0, 20, 1)
             self.sneo_wall:createWall(0, 0, 2, 3, 0, 20, 1)
             self.sneo_wall:createWall(0, 0, 3, 2, 0, 20, 1)
        end

        self.sneo_wall:createWall(1, 1, 1, 1, 1, 9999, 0)
    end	
	if self.difficulty == 2 then
        for i = 0, 6-1 do
            self.sneo_wall:createWall(
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  7, 
			  0
            )
            self.sneo_wall:createWall(
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
            self.sneo_wall:createWall(
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  63, 
			  0
            )
            self.sneo_wall:createWall(
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
            self.sneo_wall:createWall(
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 4, 3, 0}, 
			  7, 
			  0
            )
            self.sneo_wall:createWall(
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
            self.sneo_wall:createWall(
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  7, 
			  0
            )
            self.sneo_wall:createWall(
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
            self.sneo_wall:createWall(
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  7, 
			  0
            )
            self.sneo_wall:createWall(
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
            self.sneo_wall:createWall(
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  Utils.pick{2, 2, 1, 1, 1, 3, 0},  
			  Utils.pick{2, 2, 1, 1, 1, 3, 0}, 
			  7, 
			  0
            )
            self.sneo_wall:createWall(
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
        if self.wave_timer == 0 then
            self.rand = math.floor(Utils.random(1, 2))
        end
        if self.rand == 1 then
            self.sneo_wall:createWall(0, 0, 0, 0, 4, 1, 1)
            self.sneo_wall:createWall(1, 0, 0, 0, 0, 7, 1)
        end
        if self.rand == 2 then
            self.sneo_wall:createWall(4, 0, 0, 0, 0, 1, 1)
            self.sneo_wall:createWall(0, 0, 0, 0, 1, 7, 1)
        end
		
        if self.wave_timer == 0 then
            self.rand = math.floor(Utils.random(1, 3))
        end
        if self.rand == 1 then
            self.sneo_wall:createWall(4, 0, 0, 0, 3, 63, 1)
        end
        if self.rand == 2 then
            self.sneo_wall:createWall(3, 0, 0, 0, 4, 63, 1)
        end
        if self.rand == 3 then
            self.sneo_wall:createWall(0, 3, 4, 0, 0, 63, 1)
        end
		
        self.sneo_wall:createWall(0, 0, 1, 0, 4, 60, 0)
        self.sneo_wall:createWall(4, 2, 1, 0, 0, 7, 0)
        self.sneo_wall:createWall(0, 2, 3, 1, 0, 7, 0)
        self.sneo_wall:createWall(0, 2, 3, 1, 0, 7, 0)
        self.sneo_wall:createWall(0, 4, 1, 3, 1, 50, 0)
        self.sneo_wall:createWall(3, 1, 1, 4, 2, 7, 0)
        self.sneo_wall:createWall(3, 4, 0, 3, 1, 7, 0)
        self.sneo_wall:createWall(2, 1, 0, 1, 2, 7, 0)
        self.sneo_wall:createWall(2, 4, 2, 0, 4, 7, 0)
        self.sneo_wall:createWall(2, 1, 2, 0, 0, 7, 0)
        self.sneo_wall:createWall(1, 4, 2, 0, 3, 50, 0)
        self.sneo_wall:createWall(4, 2, 0, 0, 2, 7, 0)
        self.sneo_wall:createWall(0, 2, 1, 1, 1, 7, 0)
        self.sneo_wall:createWall(3, 1, 2, 1, 3, 7, 0)
        self.sneo_wall:createWall(1, 1, 4, 0, 0, 7, 0)
        self.sneo_wall:createWall(4, 2, 2, 0, 1, 7, 0)
        self.sneo_wall:createWall(3, 2, 3, 4, 2, 50, 0)
        self.sneo_wall:createWall(2, 2, 1, 2, 4, 7, 0)
        self.sneo_wall:createWall(3, 1, 1, 1, 4, 7, 0)
        self.sneo_wall:createWall(2, 2, 1, 1, 3, 7, 0)
        self.sneo_wall:createWall(3, 4, 1, 1, 1, 7, 0)
        self.sneo_wall:createWall(3, 0, 0, 4, 2, 7, 0)
        self.sneo_wall:createWall(0, 0, 0, 0, 0, 9999, 0)
    end
end

function WallCarts:update()
    super.update(self)

    self.wave_timer = self.wave_timer + DTMULT
	
    if self.wallcount < self.wallcountmax and self.wave_timer == self.sneo_wall.wallcreatetimer[self.wallcount] then
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
            elseif self.sneo_wall.emptyspot1[self.wallcount] == i or self.sneo_wall.emptyspot2[self.wallcount] == i or self.sneo_wall.emptyspot3[self.wallcount] == i or self.sneo_wall.emptyspot4[self.wallcount] == i or self.sneo_wall.emptyspot5[self.wallcount] == i then
            
			elseif self.sneo_wall.bombspot1[self.wallcount] == i or self.sneo_wall.bombspot2[self.wallcount] == i or self.sneo_wall.bombspot3[self.wallcount] == i or self.sneo_wall.bombspot4[self.wallcount] == i or self.sneo_wall.bombspot5[self.wallcount] == i then
                local bullet = self:spawnBullet("sneo/wall_bomb", SCREEN_WIDTH, (SCREEN_HEIGHT/2 + i * 34 - 170))
                bullet.wallnumber = self.wallcount
			elseif self.sneo_wall.pipisspot1[self.wallcount] == i or self.sneo_wall.pipisspot2[self.wallcount] == i or self.sneo_wall.pipisspot3[self.wallcount] == i or self.sneo_wall.pipisspot4[self.wallcount] == i or self.sneo_wall.pipisspot5[self.wallcount] == i then
                bullet = self:spawnBullet("sneo/wall_pipis", SCREEN_WIDTH, (SCREEN_HEIGHT/2 + i * 34 - 170))
                bullet.wallnumber = self.wallcount
            else
                local bullet = self:spawnBullet("sneo/wallbullet_new", SCREEN_WIDTH, (SCREEN_HEIGHT/2 + i * 34 - 172))
                bullet:setSprite("battle/bullets/sneo/mail_1")
                bullet.scale_x = 1.2
                bullet.scale_y = 1.71
                bullet.destroyable = false
                bullet.wallnumber = self.wallcount
				
                if self.sneo_wall.breakspot1[self.wallcount] == i or self.sneo_wall.breakspot2[self.wallcount] == i or self.sneo_wall.breakspot3[self.wallcount] == i or self.sneo_wall.breakspot4[self.wallcount] == i or self.sneo_wall.breakspot5[self.wallcount] == i then
                    bullet.destroyable = true
                    bullet:setSprite("battle/bullets/sneo/lilguy")
                    bullet.sprite:play(0.25, true)
                    bullet.scale_y = 1.2
                elseif self.sneo_wall.redbreakspot1[self.wallcount] == i or self.sneo_wall.redbreakspot2[self.wallcount] == i or self.sneo_wall.redbreakspot3[self.wallcount] == i or self.sneo_wall.redbreakspot4[self.wallcount] == i or self.sneo_wall.redbreakspot5[self.wallcount] == i then
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
        self.wave_timer = 0
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
            self.sneo_wall.wallsetupcount,
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