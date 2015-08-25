//General Settings \\ 
AddCSLuaFile( "shared.lua" ) 
SWEP.PrintName 		= "The Trifecta"
 
SWEP.Author 		= "Wunce"
SWEP.Instructions 	= "Fires a triangle of death." 
SWEP.Contact 		= " " 
SWEP.Purpose 		= "Alien hunting"  
SWEP.IconLetter		= "l"
SWEP.AdminSpawnable = true 
SWEP.Spawnable 		= false  
 
SWEP.ViewModelFOV 	= 64 
SWEP.ViewModel 		= "models/weapons/v_mach_m249para.mdl" --these need updating!
SWEP.WorldModel 	= "models/weapons/w_mach_m249para.mdl" 

SWEP.AutoSwitchTo 	= false 
SWEP.AutoSwitchFrom = false 
 
SWEP.Slot 			= 4
SWEP.SlotPos = 4
 
SWEP.HoldType = "ar2" 
 
SWEP.FiresUnderwater = false 
 
SWEP.Weight = 5 
 
SWEP.DrawCrosshair = false 
 
SWEP.Category = "Unique" 
 
SWEP.DrawAmmo = true 
 

 
SWEP.Base = "weapon_ironsight_base" 
//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "weapons/scout/scout_fire-1.wav" --- change this definitely
SWEP.Primary.Damage = 12
SWEP.Primary.TakeAmmo = 3 
SWEP.Primary.ClipSize = 198 
SWEP.Primary.Ammo = "AirboatGun" 
SWEP.Primary.DefaultClip = 198  
--SWEP.Primary.Spread = 0 
SWEP.Primary.NumberofShots = 1 
SWEP.Primary.Automatic = false 
SWEP.Primary.Recoil = 0.1 
SWEP.Primary.Delay = 0.4
SWEP.Primary.Force = 10 
//PrimaryFire settings\\


SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.UpgradedName = "Predator"
SWEP.EnhancedClipSize = 399
SWEP.UpgradedMat = ""
SWEP.UpgradedSound = SWEP.Primary.Sound

SWEP.IronSightsPos 		= Vector( -4.4153, 0, 2.1305 )
SWEP.IronSightsAng 		= Vector( 0, 0, 0 )

 
//SWEP:PrimaryFire\\ 
function SWEP:PrimaryAttack() 
	if ( !self:CanPrimaryAttack() ) then return end 
	
	if self.Weapon:GetDTBool( 2) then
		trishoot(self)
		self:SetNextPrimaryFire( CurTime() + 0.08 )
	else
	for q=0,2 do
		if k == 0 then
			trishoot(self)
		elseif SERVER then
			timer.Simple(0.1*q,trishoot,self)
		end
	end
	
		

 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	end
end 
 
 
 function trishoot(self)
 if self.Owner:GetActiveWeapon() != self or ( !self:CanPrimaryAttack() ) or self:Clip1() <= 0 then return; end
 self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
 if self:Clip1() < 0 then self:SetClip1(0) end
	/*----------------------------------
	left bullet
	-----------------------------------*/

local spread = true
local punch = Angle(math.Rand(-2,2),math.Rand(-2,2),0)	

	if self.Weapon:GetDTBool( 1) then
		spread = false
		punch = Angle(0,0,0)	
	end
local aim = self.Owner:GetAimVector()

local leftbullet = {}

		leftbullet.Num = self.Primary.NumberofShots 
		
		if spread then
		leftbullet.Src = self.Owner:GetShootPos() 
		leftbullet.Dir = (aim + (Vector(-aim.y,aim.x,-1)*0.01)):Normalize()
		else
		leftbullet.Src = self.Owner:GetShootPos() + Vector(-aim.y,aim.x,-1)*10
		leftbullet.Dir = aim
		end
		
		leftbullet.Spread = 0
		leftbullet.Tracer = 1
		--bullet.TracerName = "StriderTracer"
		leftbullet.Force = self.Primary.Force 
		leftbullet.Damage = self.Primary.Damage 
		--bullet.AmmoType = self.Primary.Ammo 
		self.Owner:FireBullets( leftbullet )			

	/*----------------------------------
	Right bullet
	-----------------------------------*/

local rightbullet = {}
		
		rightbullet.Num = self.Primary.NumberofShots 
		
		if spread then
		rightbullet.Src = self.Owner:GetShootPos() 
		rightbullet.Dir = (aim + (Vector(aim.y,-aim.x,-1)*0.01)):Normalize()
		else
		rightbullet.Src = self.Owner:GetShootPos() + Vector(aim.y,-aim.x,-1)*10
		rightbullet.Dir = aim
		end
		
		rightbullet.Spread = 0
		rightbullet.Tracer = 1
		--bullet.TracerName = "StriderTracer"
		rightbullet.Force = self.Primary.Force 
		rightbullet.Damage = self.Primary.Damage 
		--bullet.AmmoType = self.Primary.Ammo 
		self.Owner:FireBullets( rightbullet )		
	
	/*----------------------------------
	Top bullet
	-----------------------------------*/
local topbullet = {}
		topbullet.Num = self.Primary.NumberofShots 
		
		if spread then
		topbullet.Src = self.Owner:GetShootPos() 
		topbullet.Dir = (aim + Vector(0,0,0.01 *1.732)):Normalize() --now at the correct height
		else
		topbullet.Src = self.Owner:GetShootPos() + Vector(0,0,0.01 *1.732)*10 -- redundant calculations much?
		topbullet.Dir = aim
		end

		topbullet.Spread = 0
		topbullet.Tracer = 1
		--bullet.TracerName = "StriderTracer"
		topbullet.Force = self.Primary.Force 
		topbullet.Damage = self.Primary.Damage 
		--bullet.AmmoType = self.Primary.Ammo 
		self.Owner:FireBullets( topbullet )		
		
		
			self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ShootEffects() 
	
	 
	self:EmitSound(Sound(self.Primary.Sound)) 
	self.Owner:ViewPunch( punch ) 
	
	if self.FullyUpgraded then
	local effectdata = EffectData()
	effectdata:SetOrigin(getGunPosAng(self.Owner).Pos+self.Owner:GetForward()*18)
	effectdata:SetNormal(self.Owner:GetAimVector())
	effectdata:SetScale(1)
	util.Effect("predator_effect", effectdata)
	end
 end
 
function getGunPosAng(GUN)
    local attachmentID=GUN:LookupAttachment("anim_attachment_RH");
    return GUN:GetAttachment(attachmentID)
end
	
	