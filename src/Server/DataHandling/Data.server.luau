local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local Template = require(ServerScriptService.DataHandling.Template)
local ProfileService = require(ServerScriptService.DataHandling.ProfileService)
local Manager = require(ServerScriptService.DataHandling.Manager)

-- DataStores: Test4, Alpha
local ProfileStore = ProfileService.GetProfileStore("Alpha", Template)

local function PlayerAdded(player: Player)
	local profile = ProfileStore:LoadProfileAsync("Player_"..player.UserId)

	profile:AddUserId(player.UserId)
	profile:Reconcile()
	profile:ListenToRelease(function()
		Manager.Profiles[player] = nil
		player:Kick("Data issue; try again shortly. If this persists, contact me through the discord server.")
	end)

	if player:IsDescendantOf(Players) == true then -- stuff to run when the player first joins assuming no data errors
		Manager.Profiles[player] = profile
	else
		profile:Release()
	end
end

for _, player in Players:GetPlayers() do 
	task.spawn(PlayerAdded, player)
end

Players.PlayerAdded:Connect(PlayerAdded)

Players.PlayerRemoving:Connect(function(player: Player)
	local profile = Manager.Profiles[player]
	if not profile then return end
	profile:Release()
end)
