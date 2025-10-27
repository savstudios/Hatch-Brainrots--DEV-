local EggInfo = require(script.Parent.Parent.EggInfo)

local EggServiceServer = {}

function EggServiceServer.Init(self: EggServiceServer)
	
end

function EggServiceServer.DisplayStats(self: EggServiceServer, eggName)
    local eggData = EggInfo.Info[eggName]
end

type EggServiceServer = typeof(EggServiceServer) & {
	
}

return EggServiceServer :: EggServiceServer