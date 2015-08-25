AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" ) 
include('shared.lua')
util.PrecacheSound("items/suitchargeno1.wav")
function ENT:Initialize()
	self:SetModel( "models/healthvial.mdl") 
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
    if activator.FirstAidSpray < 4 then
	activator.FirstAidSpray = activator.FirstAidSpray + 1
	self:Remove()
		umsg.Start("SprayAmt", activator)
		umsg.Float(activator.FirstAidSpray)
		umsg.End()
	else
	self:EmitSound("items/suitchargeno1.wav")
	end
end

function ENT:SpawnFunction(ply, trace)
	if (not trace.Hit) then return end
	local entt = ents.Create("first_aid_spray");
	if entt != NULL then
	entt:SetPos(trace.HitPos + trace.HitNormal * 16) --ent is returning NULL
	entt:Spawn()
	entt:Activate()
	else
	ply:ChatPrint("fuuuuuuuuuuu")
	return entt
	end
end
