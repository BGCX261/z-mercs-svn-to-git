AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" ) 
include('shared.lua')

function ENT:Initialize()
	self:SetModel( "models/Items/357ammo.mdl") -- CHANGE THIS
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
	
	if (activator:GetAmmoCount("Grenade") < 15 and activator.clipvest == false) or (activator:GetAmmoCount("Grenade") < 30 and activator.clipvest == true)  then
	activator:GiveAmmo(5, "Grenade")
	self:Remove()
	end
	
end
end