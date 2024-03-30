include("shared.lua")

for _, v in ipairs(file.Find("gamemodes/beatrun-base/gamemode/cl/*.lua", "GAME")) do
	include("cl/" .. v)
end