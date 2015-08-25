
AddCSLuaFile( "shared.lua" ) 
SWEP.PrintName 		= "Five-Seven"
 
SWEP.Author 		= "Wunce"
SWEP.Instructions 	= "Point and shoot. Move slowly for better accuracy." 
SWEP.Contact 		= " " 
SWEP.Purpose 		= "Alien hunting"  
SWEP.IconLetter		= "c"
SWEP.AdminSpawnable = true 
SWEP.Spawnable 		= false  
 
SWEP.ViewModelFOV 	= 64 
SWEP.ViewModel 		= "models/weapons/v_pist_fiveseven.mdl" --these need updating!
SWEP.WorldModel 	= "models/weapons/w_pist_fiveseven.mdl" 
SWEP.ViewModelFlip = true
SWEP.AutoSwitchTo 	= false 
SWEP.AutoSwitchFrom = false 
 
SWEP.Slot = 1 
SWEP.SlotPos = 1
 
SWEP.HoldType = "pistol" 
 
SWEP.FiresUnderwater = false 
 
SWEP.Weight = 5 
 
SWEP.DrawCrosshair = false 
 
SWEP.Category = "Generic" 
 
SWEP.DrawAmmo = true 
 

 
SWEP.Base = "weapon_ironsight_base" 

 

SWEP.Primary.Sound = "weapons/fiveseven/fiveseven-1.wav" --- change this definitely
SWEP.Primary.Damage = 12
SWEP.Primary.TakeAmmo = 1 
SWEP.Primary.ClipSize = 16 
SWEP.EnhancedClipSize = 32
SWEP.Primary.Ammo = "pistol" 
SWEP.Primary.DefaultClip = 16 
SWEP.Primary.Tracer = 3
SWEP.Primary.NumberofShots = 1 
SWEP.Primary.Automatic = false 
SWEP.Primary.Recoil = 1
SWEP.Primary.Delay = 0.1
SWEP.Primary.Force = 25 

SWEP.HorizontalRecoil = 0.5
SWEP.VerticalRecoil = 2

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.exppownum = 150
SWEP.yintercept = 0
SWEP.UpgradedName = "Machine Pistol"
SWEP.UpgradedSound		= Sound("Weapon_MAC10.Single")
SWEP.UpgradedMat = ""

SWEP.IronSightsPos 		= Vector( 4.5114, -0.7423, 3.3629 )
SWEP.IronSightsAng 		= Vector( -0.4454, -0.0264, 0 )

function SWEP:Initialize() 
	util.PrecacheSound(self.Primary.Sound) 
	--util.PrecacheSound(self.Secondary.Sound) 
        self:SetWeaponHoldType( self.HoldType )
end 

 

	