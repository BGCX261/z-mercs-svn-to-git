AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" ) 
include('shared.lua')

util.PrecacheSound("items/suitchargeno1.wav") -- CHANGE THIS
function ENT:Initialize()
	self:SetModel( "models/props_c17/utilitypole02b.mdl") -- CHANGE THIS
	self:PhysicsInit( SOLID_VPHYSICS )      
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )   
	
	self:SetUseType(SIMPLE_USE)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
       local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableMotion(false)
	end

end


function ENT:Use( activator, caller ) -- CALL SOME VGUI SHIT
	if self.IFF == nil then
				umsg.Start("call_option", activator)
				umsg.String(glon.encode( "Activate the inferno tower systems without IFF will make it affect more targets and work faster. However, this will make it target team mates as well" ))
				umsg.End()
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
