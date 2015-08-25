AddCSLuaFile( "shared.lua" ) 
SWEP.PrintName 		= "AK-48"
 
SWEP.Author 		= "Wunce"
SWEP.Instructions 	= "Inaccurate but cheap and effective." 
SWEP.Contact 		= " " 
SWEP.Purpose 		= "Alien hunting"  
SWEP.IconLetter		= "g"
SWEP.AdminSpawnable = true 
SWEP.Spawnable 		= false  
 
SWEP.ViewModelFOV 	= 64 
SWEP.ViewModel 		= "models/weapons/v_rif_ak47.mdl" --these need updating!
SWEP.WorldModel 	= "models/weapons/w_rif_ak47.mdl" 
SWEP.ViewModelFlip = true
SWEP.AutoSwitchTo 	= false 
SWEP.AutoSwitchFrom = false 
 
SWEP.Slot 			= 2 
SWEP.SlotPos = 2 
 
SWEP.HoldType = "ar2" 
 
SWEP.FiresUnderwater = false 
 
SWEP.Weight = 5 
 
SWEP.DrawCrosshair = false 
 
SWEP.Category = "Generic" 
 
SWEP.DrawAmmo = true 
 

 
SWEP.Base = "weapon_ironsight_base" 

SWEP.Primary.Sound = "weapons/ak47/ak47-1.wav" 
SWEP.Primary.Damage = 18
SWEP.Primary.TakeAmmo = 1 
SWEP.Primary.ClipSize = 30 
SWEP.Primary.Ammo = "smg1" 
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Tracer = 0
SWEP.Primary.NumberofShots = 1 
SWEP.Primary.Automatic = true
SWEP.Primary.Recoil = 2 
SWEP.Primary.Delay = 0.1
SWEP.Primary.Force = 10 



SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.HorizontalRecoil = 3
SWEP.VerticalRecoil = 4
SWEP.exppownum = 150
SWEP.yintercept = 5
SWEP.IronSightsPos 		= Vector( 6, -6, 3 )
SWEP.IronSightsAng 		= Vector( 2, 0, 0 )
	
SWEP.UpgradedName = "Dictator"
SWEP.EnhancedClipSize = 60
SWEP.UpgradedMat = "phoenix_storms/stripes"
SWEP.UpgradedSound = SWEP.Primary.Sound