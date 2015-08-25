AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" ) 
include('shared.lua')


function ENT:Initialize()
	self:SetModel( "models/props_c17/signpole001.mdl") 
	self:PhysicsInit( SOLID_VPHYSICS )      
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )   
	
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
       local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableMotion(false)
	end

end



function ENT:SpawnFunction(ply, trace)
	if (not trace.Hit) then return end
	local entt = ents.Create("zombie_beacon");
	if entt != NULL then
	entt:SetPos(trace.HitPos + trace.HitNormal * 16) --ent is returning NULL
	entt:Spawn()
	entt:Activate()
	else
	ply:ChatPrint("fuuuuuuuuuuu")
	return entt
	end
end
