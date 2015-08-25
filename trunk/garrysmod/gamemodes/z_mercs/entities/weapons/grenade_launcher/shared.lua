//General Settings \\ 
AddCSLuaFile( "shared.lua" ) 
SWEP.PrintName 		= "Grenade Launcher" // your sweps name 
 
SWEP.Author 		= "Wunce" // Your name 
SWEP.Instructions 	= "Fires an explosive grenade. The grenade also has sharpenel." // How do pepole use your swep ? 
SWEP.Contact 		= "YourMailAdress" // How Pepole chould contact you if they find bugs, errors, etc 
SWEP.Purpose 		= "Alien hunting" // What is the purpose with this swep ? 
 
SWEP.AdminSpawnable = true // Is the swep spawnable for admin 
SWEP.Spawnable 		= false // Can everybody spawn this swep ? - If you want only admin keep this false and adminsapwnable true. 
 SWEP.IconLetter		= "l"
SWEP.ViewModelFOV 	= 64 // How much of the weapon do u see ? 
SWEP.ViewModel 		= "models/weapons/v_shotgun.mdl" // The viewModel, the model you se when you are holding it-.- 
SWEP.WorldModel 	= "models/weapons/w_shotgun.mdl" // The worlmodel, The model yu when it's down on the ground 

SWEP.AutoSwitchTo 	= false // when someone walks over the swep, chould i automatectly change to your swep ? 
SWEP.AutoSwitchFrom = false // Does the weapon get changed by other sweps if you pick them up ?
 
SWEP.Slot 			= 5 // Deside wich slot you want your swep do be in 1 2 3 4 5 6 
SWEP.SlotPos = 5// Deside wich slot you want your swep do be in 1 2 3 4 5 6 
 
SWEP.HoldType = "ar2" // How the swep is hold Pistol smg greanade melee 
 
SWEP.FiresUnderwater = false // Does your swep fire under water ? 
 
SWEP.Weight = 5 // Chose the weight of the Swep 
 
SWEP.DrawCrosshair = false // Do you want it to have a crosshair ? 
 
SWEP.Category = "Generic" // Make your own catogory for the swep 
 
SWEP.DrawAmmo = true // Does the ammo show up when you are using it ? True / False 
 
--SWEP.ReloadSound = "sound/owningyou.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.Base = "weapon_ironsight_base" 

SWEP.Primary.Sound = "weapons/ar2/ar2_altfire.wav" 
SWEP.Primary.Damage = 0
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 5
SWEP.Primary.Ammo = "grenade"
SWEP.Primary.DefaultClip = 5
SWEP.Primary.NumberofShots = 1 
SWEP.Primary.Automatic = false  
SWEP.Primary.Delay = 2 
SWEP.Primary.Force = 40 

SWEP.UpgradedName = "Red Baron"
SWEP.EnhancedClipSize = 10
SWEP.UpgradedMat = ""
SWEP.UpgradedSound = SWEP.Primary.Sound

SWEP.exppownum = 150
SWEP.yintercept = 4
SWEP.HorizontalRecoil = 1
SWEP.VerticalRecoil = 8
SWEP.IronSightsPos 		= Vector( 5.7431, -1.6786, 3.3682)
SWEP.IronSightsAng 		= Vector(0.0634, -0.0235, 0 )

function getGunPosAng(GUN)
    local attachmentID=GUN:LookupAttachment("1")
    return GUN:GetAttachment(attachmentID)
end

function SWEP:PrimaryAttack() 
	if ( !self:CanPrimaryAttack() ) then return end 


	local a = self.Owner:GetVelocity()
	local mag = math.sqrt((a.x * a.x) + (a.y * a.y) + (a.z *a.z))
	local degrees = math.exp(mag/self.exppownum) + self.yintercept
	
	local factor = 1
	if self.Weapon:GetDTBool(1) then
		factor = 0.5
	end
	
	local spreadVal = math.sin(math.Deg2Rad(degrees*0.5*factor))

	/*------------------
	 The actual grenade
	------------------*/
	if SERVER then
	
	local grennum = 1
	if self.Weapon:GetDTBool(2) and self:Clip1() > 1 then
		grennum = 2
	end
	
for q=1,grennum do
	self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
local nade = ents.Create("projectile_grenade")
nade:SetPos(self.Owner:GetShootPos())
nade:SetVar("Owner",self.Owner)
nade:SetAngles(self.Owner:GetAimVector():Angle())
nade:Spawn()
nade:Activate()
if self.FullyUpgraded then
nade.red = 2
else
nade.red = 1
end

local phys = nade:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:AddVelocity((self.Owner:GetAimVector()+Vector(math.Rand(-spreadVal,spreadVal),math.Rand(-spreadVal,spreadVal),0))*(1200*(1/factor)))
	end

	end
end
	

	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

	self:ShootEffects() 
	
	local rightpunch = -math.Rand(-self.HorizontalRecoil,self.HorizontalRecoil)
	local uppunch = -math.Rand(3,self.VerticalRecoil)
	self.Owner:ViewPunch( Angle( uppunch*factor,rightpunch*factor,0 ) )
	self:EmitSound(Sound(self.Primary.Sound)) 
	
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay)
self.reloading = false
if !self.Weapon:GetDTBool(2) then
timer.Simple(0.5,function()
self.Weapon:SendWeaponAnim(ACT_SHOTGUN_PUMP)
end)
end 
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
		if self.reloading and self.nextanim and self.nextanim < CurTime() and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
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
			
		elseif self.reloading and self.nextanim and self.nextanim < CurTime() and self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0 then
		self.Weapon:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
		self.reloading = false
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
	
	