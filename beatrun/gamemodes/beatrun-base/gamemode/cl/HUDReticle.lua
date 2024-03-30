-- local reticle = CreateClientConVar("Beatrun_HUDReticle", "1", true, false, language.GetPhrase("beatrun.convars.hudreticle"), 0, 1)

--[[
local crosshair_unarmed = Material("vgui/hud/crosshair_unarmed")
local crosshair_standard = Material("vgui/hud/crosshair_standard")

local function BeatrunReticle()
	if not reticle:GetBool() then return end

	local wep = LocalPlayer():GetActiveWeapon()

	if not IsValid(wep) or LocalPlayer():notUsingRH() then return end

	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(crosshair_standard)
	surface.DrawTexturedRect(ScrW() * 0.5 - 4, ScrH() * 0.5 - 4, 8, 8)
	surface.SetMaterial(crosshair_unarmed)
	surface.DrawTexturedRect(ScrW() * 0.5 - 4, ScrH() * 0.5 - 4, 8, 8)
end

hook.Add("HUDPaint", "BeatrunReticle", BeatrunReticle)
--]]