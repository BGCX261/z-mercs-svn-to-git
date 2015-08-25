//General Settings \\ 
AddCSLuaFile( "shared.lua" ) 
SWEP.PrintName 		= "Line Shottie" // your sweps name 
 
SWEP.Author 		= "Wunce" // Your name 
SWEP.Instructions 	= "Fires a horizonal line of bullets." // How do pepole use your swep ? 
SWEP.Contact 		= " " // How Pepole chould contact you if they find bugs, errors, etc 
SWEP.Purpose 		= "Alien hunting" // What is the purpose with this swep ? 
 
SWEP.AdminSpawnable = true // Is the swep spawnable for admin 
SWEP.Spawnable 		= false // Can everybody spawn this swep ? - If you want only admin keep this false and adminsapwnable true. 
 SWEP.IconLetter		= "l"
SWEP.ViewModelFOV 	= 64 // How much of the weapon do u see ? 
SWEP.ViewModel 		= "models/weapons/v_shot_xm1014.mdl" // The viewModel, the model you se when you are holding it-.- 
SWEP.WorldModel 	= "models/weapons/w_shot_xm1014.mdl" // The worlmodel, The model yu when it's down on the ground 
SWEP.ViewModelFlip = true
SWEP.AutoSwitchTo 	= false // when someone walks over the swep, chould i automatectly change to your swep ? 
SWEP.AutoSwitchFrom = false // Does the weapon get changed by other sweps if you pick them up ?
 
SWEP.Slot 			= 3 // Deside wich slot you want your swep do be in 1 2 3 4 5 6 
SWEP.SlotPos = 3// Deside wich slot you want your swep do be in 1 2 3 4 5 6 
 
SWEP.HoldType = "ar2" // How the swep is hold Pistol smg greanade melee 
 
SWEP.FiresUnderwater = false // Does your swep fire under water ? 
 
SWEP.Weight = 5 // Chose the weight of the Swep 
 
SWEP.DrawCrosshair = false // Do you want it to have a crosshair ? 
 
SWEP.Category = "Unique" // Make your own catogory for the swep 
 
SWEP.DrawAmmo = true // Does the ammo show up when you are using it ? True / False 
 
--SWEP.ReloadSound = "sound/owningyou.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.Base = "weapon_ironsight_base" 
//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "weapons/shotgun/shotgun_dbl_fire7.wav" // The sound that plays when you shoot :] 
SWEP.Primary.Damage = 7 // How much damage the swep is doing 
SWEP.Primary.TakeAmmo = 1 // How much ammo does it take for each shot ? 
SWEP.Primary.ClipSize = 10 // The clipsize 
SWEP.Primary.Ammo = "buckshot" // ammmo type pistol/ smg1 
SWEP.Primary.DefaultClip = 20 // How much ammo does the swep come with `? 
--SWEP.Primary.Spread = 0 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it o.1 
SWEP.Primary.NumberofShots = 16 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = false // Is the swep automatic ? 
SWEP.Primary.Recoil = 1 // How much we should punch the view 
SWEP.Primary.Delay = 1 // How long time before you can fire again 
SWEP.Primary.Force = 100 // The force of the shot 
//PrimaryFire settings\\


SWEP.UpgradedName = "Coathanger"
SWEP.EnhancedClipSize = 24
SWEP.UpgradedMat = ""
SWEP.UpgradedSound = SWEP.Primary.Sound

SWEP.IronSightsPos 		= Vector( 5.7431, -1.6786, 3.3682 )
SWEP.IronSightsAng 		= Vector( 0.0634, -0.0235, 0  )

 
//SWEP:PrimaryFire\\ 
function SWEP:PrimaryAttack() 
	if ( !self:CanPrimaryAttack() ) then return end 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
	
	local degrees = 15
	
	local factor = 1
	local rapidfactor = 1
	if self.Weapon:GetDTBool( 1) then
		factor = 2
	end
	if self.Weapon:GetDTBool( 2) then
		rapidfactor = 0.75
	end
	local spreadVal = math.sin(math.Deg2Rad(degrees*0.5*factor))
local bullet = {}

		bullet.Num = self.Primary.NumberofShots *factor
		bullet.Src = self.Owner:GetShootPos() 
		bullet.Dir = self.Owner:GetAimVector() 
		bullet.Spread = Vector( spreadVal , 0, spreadVal) 
		bullet.Tracer = 1
		--bullet.TracerName = "StriderTracer"
		bullet.Force = self.Primary.Force 
		bullet.Damage = self.Primary.Damage 
		--bullet.AmmoType = self.Primary.Ammo 
		self.Owner:FireBullets( bullet )			

	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

	self:ShootEffects() 

	 
	self:EmitSound(Sound(self.Primary.Sound)) 
 
		self:SetNextPrimaryFire( CurTime() + (self.Primary.Delay*rapidfactor ))
self.reloading = false
self.Weapon:SendWeaponAnim(ACT_SHOTGUN_PUMP)
end 
 
function SWEP:SecondaryAttack() 

end 

	function SWEP:Reload()
	if self:Clip1() < self.Primary.ClipSize then 
		self.Weapon:SendWeaponAnim(  ACT_SHOTGUN_RELOAD_START )
		self.Weapon:SendWeaponAnim(ACT_MP_RELOAD_STAND)
		self.reloading = true
		self.nextanim = CurTime() + 1
	end
	end
	
		function SWEP:Think()
		if self.reloading and self.nextanim and self.nextanim < CurTime() and self.Owner:GetAmmoCount("buckshot") > 0 then
			if self:Clip1() >= self.Primary.ClipSize then 
			
				self:SetClip1(self.Primary.ClipSize)
				self.reloading = false 
				self:SetClip1(self.Primary.ClipSize)
				self.Weapon:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
				
			else
				self.Weapon:SendWeaponAnim(  ACT_VM_RELOAD )
				self.Weapon:SendWeaponAnim(ACT_MP_RELOAD_STAND)
				self.nextanim = CurTime() + 1
				self:SetClip1(self:Clip1()+ 1)
				if (SERVER) then
					self.Owner:RemoveAmmo( 1 , self.Primary.Ammo) 
				end
			end
			
		elseif self.reloading and self.nextanim and self.nextanim < CurTime() and self.Owner:GetAmmoCount("buckshot") <= 0 then
		self.Weapon:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
		self.reloading = false
		end
		
		if self:GetDTBool(2) and !self.Primary.Automatic then
		self.Primary.Automatic = true
		end
		
		if self:GetDTBool(3) and self.Primary.ClipSize != self.EnhancedClipSize then
	self.Primary.ClipSize = self.EnhancedClipSize
	self:Reload()
		end

		if !self.FullyUpgraded and self:GetDTBool(1) and self:GetDTBool(2) and self:GetDTBool(3) then
		 self.PrintName = self.UpgradedName
		 self.FullyUpgraded = true
		 self:SetMaterial(self.UpgradedMat)
		 self.Primary.Sound = self.UpgradedSound 
		end
		
	end
	
	