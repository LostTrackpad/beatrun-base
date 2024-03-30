local function ToggleGamemode(gm)
	net.Start("Beatrun_ToggleGamemode")
		net.WriteString(gm)
	net.SendToServer()
end

hook.Add("AddToolMenuCategories", "Beatrun_Category", function()
	spawnmenu.AddToolCategory("Beatrun", "Client", language.GetPhrase("beatrun.toolsmenu.client"))
	spawnmenu.AddToolCategory("Beatrun", "Server", language.GetPhrase("beatrun.toolsmenu.server"))
	spawnmenu.AddToolCategory("Beatrun", "About", language.GetPhrase("beatrun.toolsmenu.about"))
end)

hook.Add("PopulateToolMenu", "Beatrun_ToolMenu", function()
	spawnmenu.AddToolMenuOption("Beatrun", "About", "beatrun_about", "#beatrun.toolsmenu.about", "", "", function(panel)
		panel:Help("#beatrun.toolsmenu.about.name")
		panel:Help("#beatrun.toolsmenu.about.version")
		panel:Help(" ")
		panel:Help("#beatrun.toolsmenu.about.ogcreator")
		panel:Help("#beatrun.toolsmenu.about.decompiler")
		panel:Help("#beatrun.toolsmenu.about.modder")
		panel:Help("#beatrun.toolsmenu.about.basecreator")

		local button = vgui.Create( "DButton", panel )
		button:SetSize( 0, 20 )
		button:SetText( "#beatrun.repourlbutton.upstream" )
		button.DoClick = function()
		    gui.OpenURL( "https://github.com/JonnyBro/beatrun" )
		end
		panel:AddItem(button)

		local button2 = vgui.Create( "DButton", panel )
		button2:SetSize( 0, 20 )
		button2:SetText( "#beatrun.repourlbutton.base" )
		button2.DoClick = function()
		    gui.OpenURL( "https://github.com/LostTrackpad/beatrun-base" )
		end
		panel:AddItem(button2)
	end)

	spawnmenu.AddToolMenuOption("Beatrun", "Client", "beatrun_viewbob", "#beatrun.toolsmenu.viewbob.name", "", "", function(panel)
		panel:ClearControls()
		panel:SetName("#beatrun.toolsmenu.viewbob.desc")

		panel:CheckBox("#beatrun.toolsmenu.viewbob.stabilization", "Beatrun_ViewbobStabilized")
		panel:ControlHelp("#beatrun.toolsmenu.viewbob.stabilizationdesc")

		panel:NumSlider("#beatrun.toolsmenu.viewbob.intensity", "Beatrun_ViewbobIntensity", -100, 100, 0)
	end)

	spawnmenu.AddToolMenuOption("Beatrun", "Client", "beatrun_gameplay", "#beatrun.toolsmenu.gameplay.name", "", "", function(panel)
		panel:ClearControls()
		panel:SetName("#beatrun.toolsmenu.gameplay.desc")

		panel:CheckBox("#beatrun.toolsmenu.gameplay.quickturnground", "Beatrun_QuickturnGround")
		panel:ControlHelp("#beatrun.toolsmenu.gameplay.quickturngrounddesc")

		panel:CheckBox("#beatrun.toolsmenu.gameplay.quickturnhandsonly", "Beatrun_QuickturnHandsOnly")
		panel:ControlHelp("#beatrun.toolsmenu.gameplay.quickturnhandsonlydesc")

		panel:CheckBox("#beatrun.toolsmenu.gameplay.puristmode", "Beatrun_PuristMode")
		panel:ControlHelp(language.GetPhrase("beatrun.toolsmenu.gameplay.puristmodedesc"))

		panel:CheckBox("#beatrun.toolsmenu.gameplay.disablegrapple", "Beatrun_DisableGrapple")
		panel:ControlHelp("#beatrun.toolsmenu.gameplay.disablegrappledesc")
	end)

	spawnmenu.AddToolMenuOption("Beatrun", "Server", "beatrun_misc", "#beatrun.toolsmenu.misc.name", "", "", function(panel)
		panel:ClearControls()
		panel:SetName("#beatrun.toolsmenu.misc.desc")

		panel:CheckBox("#beatrun.toolsmenu.misc.propspawn", "Beatrun_AllowPropSpawn")
		panel:ControlHelp("#beatrun.toolsmenu.misc.propspawndesc")

		panel:CheckBox("#beatrun.toolsmenu.misc.overdrivemp", "Beatrun_AllowOverdriveInMultiplayer")
		panel:ControlHelp("#beatrun.toolsmenu.misc.overdrivempdesc")

		panel:CheckBox("#beatrun.toolsmenu.misc.healthregen", "Beatrun_HealthRegen")
		panel:ControlHelp("#beatrun.toolsmenu.misc.healthregendesc")
	end)

	spawnmenu.AddToolMenuOption("Beatrun", "Server", "beatrun_moves", "#beatrun.toolsmenu.moves.name", "", "", function(panel)
		panel:ClearControls()
		panel:SetName("#beatrun.toolsmenu.moves.desc")
		panel:Help(language.GetPhrase("beatrun.toolsmenu.moves.help"))

		panel:NumSlider("#beatrun.toolsmenu.moves.speedlimit", "Beatrun_SpeedLimit", 325, 1000, 0)
		panel:ControlHelp(language.GetPhrase("beatrun.toolsmenu.moves.speedlimitdesc"))

		panel:CheckBox("#beatrun.toolsmenu.moves.forcepuristmode", "Beatrun_PuristModeForce")
		panel:ControlHelp("#beatrun.toolsmenu.moves.forcepuristmodedesc")

		panel:CheckBox("#beatrun.toolsmenu.moves.realisticwallrunning", "Beatrun_PuristWallrun")
		panel:ControlHelp("#beatrun.toolsmenu.moves.realisticwallrunningdesc")

		local divider = vgui.Create("DHorizontalDivider")
		panel:AddItem(divider)

		panel:CheckBox("#beatrun.toolsmenu.moves.kickglitch", "Beatrun_KickGlitch")
		panel:ControlHelp(language.GetPhrase("beatrun.toolsmenu.moves.kickglitchdesc"))

		panel:CheckBox("#beatrun.toolsmenu.moves.kickglitchversion", "Beatrun_OldKickGlitch")
		panel:ControlHelp(language.GetPhrase("beatrun.toolsmenu.moves.kickglitchversiondesc"))

		panel:CheckBox("#beatrun.toolsmenu.moves.quakejump", "Beatrun_QuakeJump")
		panel:ControlHelp(language.GetPhrase("beatrun.toolsmenu.moves.quakejumpdesc"))

		panel:CheckBox("#beatrun.toolsmenu.moves.sidestep", "Beatrun_SideStep")
		panel:ControlHelp(language.GetPhrase("beatrun.toolsmenu.moves.sidestepdesc"))

		panel:CheckBox("#beatrun.toolsmenu.moves.disarm", "Beatrun_Disarm")
		panel:ControlHelp(language.GetPhrase("beatrun.toolsmenu.moves.disarmdesc"))

		local divider = vgui.Create("DHorizontalDivider")
		panel:AddItem(divider)

		panel:Help("#beatrun.toolsmenu.moves.divesettings")

		panel:CheckBox("#beatrun.toolsmenu.moves.totsugeki", "Beatrun_Totsugeki")
		panel:ControlHelp(language.GetPhrase("beatrun.toolsmenu.moves.totsugekidesc"))

		panel:CheckBox("#beatrun.toolsmenu.moves.totsugekispam", "Beatrun_TotsugekiSpam")
		panel:ControlHelp("#beatrun.toolsmenu.moves.totsugekispamdesc")

		panel:CheckBox("#beatrun.toolsmenu.moves.totsugekiheading", "Beatrun_TotsugekiHeading")
		panel:ControlHelp("#beatrun.toolsmenu.moves.totsugekiheadingdesc")

		panel:CheckBox("#beatrun.toolsmenu.moves.totsugekidirection", "Beatrun_TotsugekiDir")
		panel:ControlHelp(language.GetPhrase("beatrun.toolsmenu.moves.totsugekidirectiondesc"))
	end)
end)
