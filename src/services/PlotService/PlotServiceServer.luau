local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlotServiceServer = {}

function PlotServiceServer.PlayerLoaded(self: PlotServiceServer, player: Player)
    local plots = self:GetAvailablePlots()

    -- allocate a plot
    local plot = plots[math.random(1, #plots)]
    local owner: ObjectValue = plot.Owner
    owner.Value = player

    print("Set plot "..plot.Name.."'s Owner to: "..player.Name)

    self:AddPlot(player, plot)
end

function PlotServiceServer.PlayerLeft(self: PlotServiceServer, player: Player)
    self:RemovePlotOwner(player)
end

function PlotServiceServer.AddPlot(self: PlotServiceServer, player: Player, plotSpawn: Part)
    local plot = ReplicatedStorage.Assets.Plot:Clone()
    local char = player.Character or player.CharacterAdded:Wait()

    plot.Owner.Value = player
    plot.Name = player.Name.."Plot"

    plot.Parent = workspace
    plot:PivotTo(plotSpawn.CFrame)

    char.HumanoidRootPart.CFrame = plot.Spawn.CFrame
end

function PlotServiceServer.RemovePlotOwner(self: PlotServiceServer, player: Player)
    for _, plotSpawns in workspace.PlotSpawns:GetChildren() do
        if plotSpawns.Owner.Value == player then 
            plotSpawns.Owner.Value = nil

            -- removes plot
            workspace:FindFirstChild(player.Name.."Plot"):Destroy()

            print("Removed plot "..plotSpawns.Name.."'s Owner")
        end
    end
end

function PlotServiceServer.GetAvailablePlots(self: PlotServiceServer)
    local availPlots = {}

    for _, plotSpawn in workspace.PlotSpawns:GetChildren() do
        if plotSpawn.Owner.Value ~= nil then continue end
        
        table.insert(availPlots, plotSpawn)
    end

    return availPlots
end

type PlotServiceServer = typeof(PlotServiceServer)

return PlotServiceServer :: PlotServiceServer