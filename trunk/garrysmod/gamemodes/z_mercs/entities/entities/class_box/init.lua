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


end

function ENT:Use( activator, caller )
	
	if activator:GetActiveWeapon() == NULL then
	activator.lasbox = true
	activator.ShieldModule = 1
	activator.FirstAidSpray = 2
	activator:SetArmor(50)
		if self.Classy == 1 then -- GENERAL OFFENSE
			activator:Give("special_machinegun")
			activator:Give("basic_shottie")
			activator:Give("beasty_deagle")
			activator.clipvest = true
			activator:GiveAmmo( 128, "CombineCannon" )
			activator:GiveAmmo( 400, "AirboatGun" )
			activator:GiveAmmo( 64, "Buckshot" )
			
		elseif self.Classy == 2 then -- SUPPORT
			activator:Give("beasty_machinegun")
			activator:Give("grenade_launcher")
			activator:Give("basic_pistol")
			activator.FirstAidSpray = 4
			activator:GiveAmmo( 15, "Grenade" )
			activator:GiveAmmo( 200, "AirboatGun" )
			activator:GiveAmmo( 128, "Pistol" )
			
		elseif self.Classy == 3 then -- IMPACT
			activator:Give("line_shottie")
			activator:Give("cool_ak")
			activator:Give("recharge_pistol")
			activator.GasMask = true
			activator.ShieldModule = 2
			activator:GiveAmmo( 40, "Buckshot" )
			activator:GiveAmmo( 240, "SMG1" )
		end
		
	end
end

