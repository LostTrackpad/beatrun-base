local mousex = 0
local mousey = 0
local inf = math.huge

Course_StartPos = Course_StartPos or Vector()
Course_StartAng = Course_StartAng or 0

if SERVER then
	function BuildMode_Toggle(ply)
		if not ply.BuildMode and not ply:IsSuperAdmin() and not ply.BuildModePerm then return end

		ply.BuildMode = not ply.BuildMode

		ply:SetMoveType(MOVETYPE_WALK)
		CheckpointNumber = 1

		net.Start("BuildMode")
			net.WriteBool(ply.BuildMode)
		net.Send(ply)
	end

	concommand.Add("buildmode", function(ply, cmd, args)
		BuildMode_Toggle(ply)
	end)

	net.Receive("BuildMode_Place", function(len, ply)
		if not ply.BuildMode then return end

		local prop = net.ReadUInt(16)

		if prop == 65535 then
			prop = net.ReadString()
		end

		local x = net.ReadFloat()
		local y = net.ReadFloat()
		local z = net.ReadFloat()
		local ang = net.ReadAngle()
		local vec = Vector(x, y, z)
		local vecextra = net.ReadVector()

		if not isstring(prop) then
			local a = ents.Create("prop_physics")
			a:SetModel(buildmode_props[prop])

			CustomPropMat(a)

			a:SetPos(vec)
			a:SetAngles(ang)
			a:Spawn()

			local phys = a:GetPhysicsObject()
			phys:EnableMotion(false)
			phys:Sleep()

			a:PhysicsDestroy()
			a:SetHealth(inf)
		else
			local a = ents.Create(prop)
			local prespawn = entplacefunc_prespawn[prop]

			a:SetPos(vec)
			a:SetAngles(ang)

			if prespawn and entplacefunc[prop] then
				entplacefunc[prop](a, vecextra, vec)
			end

			a:Spawn()

			if not prespawn and entplacefunc[prop] then
				entplacefunc[prop](a, vecextra, vec)
			end
		end

		table.insert(buildmode_placed, a)
	end)

	net.Receive("BuildMode_Duplicate", function(len, ply)
		if not ply.BuildMode then return end

		local selected = net.ReadTable()
		local selectedents = net.ReadTable()

		for _, v in pairs(selected) do
			local a = ents.Create("prop_physics")
			a:SetModel(v:GetModel())

			CustomPropMat(a)

			a:SetPos(v:GetPos())
			a:SetAngles(v:GetAngles())
			a:Spawn()
			a.hr = v.hr

			CustomPropMat(a)

			local phys = a:GetPhysicsObject()
			phys:EnableMotion(false)
			phys:Sleep()

			a:PhysicsDestroy()
			a:SetHealth(inf)
		end

		for _, v in pairs(selectedents) do
			local a = ents.Create(v:GetClass())

			a:SetPos(v:GetPos())
			a:SetAngles(v:GetAngles())
			a:Spawn()
		end
	end)

	net.Receive("BuildMode_Delete", function(len, ply)
		if not ply.BuildMode then return end

		local selected = net.ReadTable()

		for _, v in pairs(selected) do
			if IsValid(v) then
				v:Remove()
			end
		end
	end)

	net.Receive("BuildMode_Highlight", function(len, ply)
		if not ply.BuildMode then return end

		local selected = net.ReadTable()

		for _, v in pairs(selected) do
			v.hr = not v.hr

			CustomPropMat(v)
		end
	end)

	net.Receive("BuildMode_Remove", function(len, ply)
		if not ply.BuildMode then return end

		local ent = net.ReadEntity()

		SafeRemoveEntity(ent)
	end)

	net.Receive("BuildMode_ReadSave", function(len, ply)
		if not ply.BuildMode then return end

		local a = net.ReadData(len)
		local props = util.JSONToTable(a)

		for _, v in pairs(props) do
			local a = ents.Create("prop_physics")

			a:SetModel(buildmode_props[v.model])

			CustomPropMat(a)

			a:SetPos(v.pos + ply:EyePos())
			a:SetAngles(v.ang)
			a:Spawn()

			local phys = a:GetPhysicsObject()
			phys:EnableMotion(false)
			phys:Sleep()

			a:PhysicsDestroy()
			a:SetHealth(inf)
		end
	end)

	net.Receive("BuildMode_Checkpoint", function(len, ply)
		if not ply.BuildMode then return end

		local x = net.ReadFloat()
		local y = net.ReadFloat()
		local z = net.ReadFloat()

		LoadCheckpoints()

		local a = ents.Create("tt_cp")
		a:SetPos(Vector(x, y, z))
		a:SetCPNum(table.Count(Checkpoints) + 1)
		a:Spawn()

		LoadCheckpoints()
	end)

	net.Receive("BuildMode_Entity", function(len, ply)
		if not ply.BuildMode then return end

		local ent = net.ReadString()
		local x = net.ReadFloat()
		local y = net.ReadFloat()
		local z = net.ReadFloat()
		local a = ents.Create(ent)
		a:SetPos(Vector(x, y, z))

		if entplacefunc[ent] then
			entplacefunc[ent](a)
		end

		a:Spawn()
	end)

	net.Receive("BuildMode_SetSpawn", function(len, ply)
		if not ply.BuildMode then return end

		local x = net.ReadFloat()
		local y = net.ReadFloat()
		local z = net.ReadFloat()
		local ang = net.ReadFloat()

		Course_StartPos:SetUnpacked(x, y, z)
		Course_StartAng = ang
	end)

	return
end