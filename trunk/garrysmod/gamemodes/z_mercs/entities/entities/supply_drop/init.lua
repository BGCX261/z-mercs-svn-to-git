AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" ) 
include('shared.lua')


function ENT:Initialize()
	self:SetModel( "models/Items/ammoCrate_Rockets.mdl") -- CHANGE THIS
	self:PhysicsInit( SOLID_VPHYSICS )      
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )   
	
	self:SetUseType(SIMPLE_USE)

       local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	SUPPLYDROP = self
	
	timer.Simple(45,function()
	
		if self:IsValid() then
		self:Remove()
		SUPPLYDROP = nil
		end
	end)
end
