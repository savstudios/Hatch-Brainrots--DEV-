--!strict

local EggInfo = require(script.Parent.EggInfo)

local SpawnServiceServer = {}

function SpawnServiceServer.Init(self: SpawnServiceServer)
	print("SpawnServiceServer initalised.")
	
	-- queue's all eggs that are meant to be spawned
	local spawnQueue = {}
	self.spawnQueue = spawnQueue
	
	local eggWeights = 0
	self.eggWeights = eggWeights
end

function SpawnServiceServer.SelectEggRandom(self: SpawnServiceServer)
	self.eggWeights = 0
	
	for _, egg in pairs(EggInfo.Info) do
		self.eggWeights += egg.Weight
	end
	
	local randomWeight = math.random(1, self.eggWeights)
	local weight = 0
	
	for _, egg in pairs(EggInfo.Info) do
		weight += egg.Weight
		if randomWeight <= weight then
			self:AddEggToQueue(egg.Name)
		end
	end
end

function SpawnServiceServer.AddEggToQueue(self: SpawnServiceServer, item: string)
	table.insert(self.spawnQueue, item)
	print("Added: "..item.." to queue.")
end

function SpawnServiceServer.SpawnEgg(self: SpawnServiceServer)
	
	-- remove first index so it's first come, first serve
	print("Removing: "..self.spawnQueue[1])
	table.remove(self.spawnQueue, 1)
	
	if #self.spawnQueue == 0 then 
		warn("Spawn queue is empty.")
	end
end

type SpawnServiceServer = typeof(SpawnServiceServer) & {
	spawnQueue: {string},
	eggWeights: number,
}

return SpawnServiceServer :: SpawnServiceServer