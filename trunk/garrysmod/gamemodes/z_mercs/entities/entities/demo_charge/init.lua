AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" ) 
include('shared.lua')

util.PrecacheSound("items/suitchargeno1.wav") -- CHANGE THIS
function ENT:Initialize()
	self:SetModel( "models/weapons/w_c4_planted.mdl") -- CHANGE THIS
	self:PhysicsInit( SOLID_VPHYSICS )      
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )   
	
	
	self:SetUseType(SIMPLE_USE)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
       local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
self.checkradius = CurTime() + 1
self:AddEffects(EF_BRIGHTLIGHT)
end


function ENT:Use( activator, caller )
if CurObj == "Demo" then
				for k, ply in pairs(player.GetAll()) do
					umsg.Start("NEWOBJ", ply)
					umsg.String(glon.encode("Defend "..activator:Nick().." as he defuses the bomb."))
					umsg.End()
				end
				OVERRIDE = activator
				MassHorde = true
	umsg.Start("call_defuse", activator)
	umsg.End()
	end
end

function ENT:Think()
if self.defused and CurObj == "Demo" then
	for k, ply in pairs(player.GetAll()) do
	ply.Cash = ply.Cash + 250
	sendmoney(ply, ply.Cash)
		umsg.Start("OBJSUCCESS", ply)
		umsg.String(glon.encode("Bomb defused. Structures saved."))
		umsg.End()
		
						umsg.Start("ObjMarker", nil)
						umsg.Vector(Vector(0,0,0))
						umsg.End()
						
			umsg.Start("Timer", ply) -- Probably could be sent with the one above.
			umsg.Float(nil)
			umsg.End()
		ObjStrRte(ply, 1)
	end
	timer.Stop("Demo")
	OVERRIDE = nil
	MassHorde = false
	CurObj = nil
	NextObjTime = CurTime() + 120
	self:Remove()
	
	elseif !self.defused and self.checkradius and self.checkradius <= CurTime() then
	
	for k, ply in pairs(player.GetAll()) do
		local distance = ply:GetPos():Distance(self:GetPos())
		MassHorde = false
		if distance < 300 then
			MassHorde = true
		end
		if OVERRIDE and ply == OVERRIDE and distance > 300 then
			OVERRIDE = nil
		end
		
	end
	self.checkradius = CurTime() + 1
	
	end
end

function ENT:SpawnFunction(ply, trace)
	if (not trace.Hit) then return end
	local entt = ents.Create("demo_charge");
	if entt != NULL then
	entt:SetPos(trace.HitPos + trace.HitNormal * 16) --ent is returning NULL
	entt:Spawn()
	entt:Activate()
	else
	ply:ChatPrint("fuuuuuuuuuuu")
	return entt
	end
end
