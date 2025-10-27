--!strict

local EggInfo = require(script.Parent.Parent.EggInfo)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local SPAWN_COOLDOWN = 4
local SpawnServiceServer = {}

function SpawnServiceServer.Init(self: SpawnServiceServer)
	print("SpawnServiceServer initalised.")
	
	-- queue's all eggs that are meant to be spawned
	local spawnQueue = {}
	self.spawnQueue = spawnQueue
	
	local eggWeights = 0
	self.eggWeights = eggWeights

	self.SPAWN_COOLDOWN = SPAWN_COOLDOWN
end

function SpawnServiceServer.SelectEggRandom(self: SpawnServiceServer)
	self.eggWeights = 0
	
	for _, egg in pairs(EggInfo.Info) do
		self.eggWeights += egg.Weight
	end
	
	local randomWeight = math.random() * self.eggWeights
	local weight = 0
	
	for _, egg in pairs(EggInfo.Info) do
		weight += egg.Weight
		if randomWeight <= weight then
			self:AddEggToQueue(egg.Name)
			break
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
	self:DisplayEgg(self.spawnQueue[1])
	table.remove(self.spawnQueue, 1)
	
	if #self.spawnQueue == 0 then 
		warn("Spawn queue is empty.")
	end
end

function SpawnServiceServer.DisplayEgg(self: SpawnServiceServer, eggType: string)
	local eggsAssets = ReplicatedStorage.Assets.Eggs
	local egg: Model = eggsAssets:WaitForChild(eggType, 3):Clone()

	local conveyor = workspace.Conveyor

	egg.Parent = workspace.ConveyorEggs
	egg:PivotTo(conveyor.Start.WorldCFrame)

	-- tweening
	local dummyCFrame = Instance.new("CFrameValue")
	dummyCFrame.Value = egg:GetPivot()

	dummyCFrame:GetPropertyChangedSignal("Value"):Connect(function()
		egg:PivotTo(dummyCFrame.Value)
	end)

	local tweenInfo = TweenInfo.new(50, Enum.EasingStyle.Linear)
	local goal = {Value = conveyor.End.WorldCFrame}

	local move: Tween = TweenService:Create(dummyCFrame, tweenInfo, goal)
	move:Play()

	-- delete egg once crossed the conveyor
	move.Completed:Connect(function()
		egg:Destroy()
	end)
end

type SpawnServiceServer = typeof(SpawnServiceServer) & {
	spawnQueue: {string},
	eggWeights: number,
	SPAWN_COOLDOWN: number,
}

return SpawnServiceServer :: SpawnServiceServer