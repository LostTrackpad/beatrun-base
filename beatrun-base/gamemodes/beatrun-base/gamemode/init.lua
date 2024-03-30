AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

for _, v in ipairs(file.Find("gamemodes/beatrun-base/gamemode/cl/*.lua", "GAME")) do
	print(v)

	AddCSLuaFile("cl/" .. v)
end

for _, v in ipairs(file.Find("gamemodes/beatrun-base/gamemode/sh/*.lua", "GAME")) do
	print(v)

	AddCSLuaFile("sh/" .. v)
	include("sh/" .. v)
end

for _, v in ipairs(file.Find("gamemodes/beatrun-base/gamemode/sv/*.lua", "GAME")) do
	print(v)

	include("sv/" .. v)
end