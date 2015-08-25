AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" ) 
include('shared.lua')

function ENT:Initialize()
	self:SetModel( "models/props/CS_militia/reload_scale.mdl") -- CHANGE THIS
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
	if activator:GetActiveWeapon():GetClass() != "catalyst_rifle" and !activator:GetActiveWeapon().Rapid then
	activator:GetActiveWeapon().Rapid = true
	activator:GetActiveWeapon():SetDTBool( 2, activator:GetActiveWeapon().Rapid )
	self:Remove()
	end
	end
end
