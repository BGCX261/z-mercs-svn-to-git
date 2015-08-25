AddCSLuaFile( "shared.lua" ) 
SWEP.PrintName 		= "LMG"
 
SWEP.Author 		= "Wunce"
SWEP.Instructions 	= "Fires a stream of bullets" 
SWEP.Contact 		= " " 
SWEP.Purpose 		= "Alien hunting"  
SWEP.IconLetter		= "d"
SWEP.AdminSpawnable = true 
SWEP.Spawnable 		= false  
 
SWEP.ViewModelFOV 	= 64 
SWEP.ViewModel 		= "models/weapons/v_mach_m249para.mdl" 
SWEP.WorldModel 	= "models/weapons/w_mach_m249para.mdl" 

SWEP.AutoSwitchTo 	= false 
SWEP.AutoSwitchFrom = false 
 
SWEP.Slot 			= 4 
SWEP.SlotPos = 4 
 
SWEP.HoldType = "ar2" 
 
SWEP.FiresUnderwater = false 
 
SWEP.Weight = 5 
 
SWEP.DrawCrosshair = false 
 
SWEP.Category = "Generic" 
 
SWEP.DrawAmmo = true 
 

 
SWEP.Base = "weapon_ironsight_base" 

SWEP.Primary.Sound = "weapons/famas/famas-1.wav" 
SWEP.Primary.Damage = 18
SWEP.Primary.TakeAmmo = 1 
SWEP.Primary.ClipSize = 100 
SWEP.Primary.Ammo = "AirboatGun" 
SWEP.Primary.DefaultClip = 100  
SWEP.Primary.Tracer = 5
SWEP.Primary.NumberofShots = 1 
SWEP.Primary.Automatic = true 
SWEP.Primary.Recoil = 2 
SWEP.Primary.Delay = 0.2
SWEP.Primary.Force = 20 



SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.HorizontalRecoil = 1.5
SWEP.VerticalRecoil = 2.5
SWEP.exppownum = 100
SWEP.yintercept = 2
SWEP.IronSightsPos 		= Vector( -4.4153, 0, 2.1305 )
SWEP.IronSightsAng 		= Vector( 0, 0, 0 )

SWEP.UpgradedName = "The Beast"
SWEP.EnhancedClipSize = 999
SWEP.UpgradedMat = "phoenix_storms/stripes"
SWEP.UpgradedSound = SWEP.Primary.Sound
