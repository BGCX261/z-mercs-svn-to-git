AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" ) 
include('shared.lua')

util.PrecacheSound("items/suitchargeno1.wav") -- CHANGE THIS
function ENT:Initialize()
	self:SetModel( "models/Items/car_battery01.mdl") -- CHANGE THIS
	self:PhysicsInit( SOLID_VPHYSICS )      
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )   
	
	
	self:SetUseType(SIMPLE_USE)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
       local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end

end


function ENT:Use( activator, caller )
AltUp(activator, activator.Altruism ,14)
			umsg.Start("Timer", activator)
			umsg.Float(CurTime() + 90)
			umsg.End()
	OVERRIDE = activator
	
	if 1 == math.random(1,4) then
	MassHorde = true
	end
	
	timer.Create("zombiepriority", 90 , 1 , function()
	OVERRIDE = nil
	MassHorde = false
	--timer.Stop("zombiepriority")
	end)
	self:EmitSound("items/suitchargeno1.wav") -- CHANGE THIS
	self:Remove()
	end



function ENT:SpawnFunction(ply, trace)
	if (not trace.Hit) then return end
	local entt = ents.Create("zombie_beacon");
	if entt != NULL then
	entt:SetPos(trace.HitPos + trace.HitNormal * 16)
	entt:Spawn()
	entt:Activate()
	else
	ply:ChatPrint("fuuuuuuuuuuu")
	return entt
	end
end
