AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" ) 
include('shared.lua')

function ENT:Initialize()
	self:SetModel( "models/items/healthkit.mdl") 
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
if !self.plyspawner or self.plyspawner == activator or self.plyspawner.wepsharing then
		for group = 1,7 do
		if  activator.hitgroups[group] and group != 3 then
		activator.hitgroups[group] = maxlimb[group]
		end
		end
		activator:SetHealth(100)
		activator.SlowBleedOut = false
		
LegDamage(activator,activator.hitgroups[HITGROUP_LEFTLEG], activator.hitgroups[HITGROUP_RIGHTLEG])
headandbodydamage(activator, activator.hitgroups[HITGROUP_HEAD], activator.hitgroups[HITGROUP_CHEST])
ArmDamage(activator, activator.hitgroups[HITGROUP_LEFTARM],activator.hitgroups[HITGROUP_RIGHTARM])

self:Remove()
end
end

function ENT:SpawnFunction(ply, trace)
	if (not trace.Hit) then return end
	local entt = ents.Create("full_heal");
	if entt != NULL then
	entt:SetPos(trace.HitPos + trace.HitNormal * 16)
	entt:Spawn()
	entt:Activate()
	else
	ply:ChatPrint("fuuuuuuuuuuu")
	return entt
	end
end


