local ServerScriptService = game:GetService("ServerScriptService")

local services = ServerScriptService.Services

local spawnService = require(services.SpawnService.SpawnServiceServer)

spawnService:Init()

while task.wait(spawnService.SPAWN_COOLDOWN) do
	spawnService:SelectEggRandom()
	
	spawnService:SpawnEgg()
end