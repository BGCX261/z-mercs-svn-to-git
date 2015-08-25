AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" ) 
include('shared.lua')


function ENT:Initialize()
	self:SetModel( "models/hunter/misc/squarecap1x1x1.mdl") -- CHANGE THIS
	self:PhysicsInit( SOLID_VPHYSICS )      
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )   
	
	self:SetUseType(SIMPLE_USE)

       local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableMotion(false)
	end

end


function ENT:Use( activator, caller ) -- CALL SOME VGUI SHIT
	if self.IFF == nil then
				umsg.Start("call_option", activator)
				umsg.String(glon.encode( "Activating the turret without IFF will make it target everyone but due to the lack of protocols, it will fire faster." ))
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
