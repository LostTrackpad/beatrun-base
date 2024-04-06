VERSIONGLOBAL = "v1.0?"

--DeriveGamemode("sandbox")
-- Controls whether Beatrun's "derived" from Sandbox, which gives you the Spawnmenu and stuff.

GM.Name = "Beatrun Base"
GM.Author = "who cares"
GM.Email = "whocares@noone.com"
GM.Website = "www.mirrorsedge.com xd"

include("player_class/player_beatrun.lua")

for _, v in ipairs(file.Find("gamemodes/beatrun-base/gamemode/sh/*.lua", "GAME", "nameasc")) do
	AddCSLuaFile("sh/" .. v)
	include("sh/" .. v)
end