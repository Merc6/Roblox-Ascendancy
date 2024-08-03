local ClientMainEvent = game.ReplicatedStorage.Events.ClientMain
local UserInputService = game:GetService('UserInputService')

local keyMap = {
	[Enum.KeyCode.C] = 1,
	[Enum.KeyCode.B] = 2
}

UserInputService.InputBegan:Connect(function(key, gameProcessed)
	if gameProcessed then return end
	local code = keyMap[key.KeyCode]
	if code ~= nil then
		ClientMainEvent:FireServer(code)
	end
end)
