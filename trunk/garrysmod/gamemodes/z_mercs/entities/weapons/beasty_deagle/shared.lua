AddCSLuaFile( "shared.lua" ) 
SWEP.PrintName 		= "Desert Eagle"
 
SWEP.Author 		= "Wunce"
SWEP.Instructions 	= "Fires beasty shots of ultra-death" 
SWEP.Contact 		= " " 
SWEP.Purpose 		= "Alien hunting"  
SWEP.IconLetter		= "e"
SWEP.AdminSpawnable = true 
SWEP.Spawnable 		= false  
 
SWEP.ViewModelFOV 	= 64 
SWEP.ViewModel 		= "models/weapons/v_pist_deagle.mdl" 
SWEP.WorldModel 	= "models/weapons/w_pist_deagle.mdl" 
SWEP.ViewModelFlip = true
SWEP.AutoSwitchTo 	= false 
SWEP.AutoSwitchFrom = false 
 
SWEP.Slot 			= 1 
SWEP.SlotPos = 1 
 
SWEP.HoldType = "pistol" 
 
SWEP.FiresUnderwater = false 
 
SWEP.Weight = 5 
 
SWEP.DrawCrosshair = false 
 
SWEP.Category = "Generic" 
 
SWEP.DrawAmmo = true 
 

 
SWEP.Base = "weapon_ironsight_base" 

 

SWEP.Primary.Sound = "weapons/deagle/deagle-1.wav"
SWEP.Primary.Damage = 50
SWEP.Primary.TakeAmmo = 1 
SWEP.Primary.ClipSize = 8 
SWEP.Primary.Ammo = "CombineCannon" 
SWEP.Primary.DefaultClip = 8 
SWEP.Primary.Tracer = 1
SWEP.Primary.NumberofShots = 1 
SWEP.Primary.Automatic = false 
SWEP.Primary.Recoil = 3 
SWEP.Primary.Delay = 0.5
SWEP.Primary.Force = 50

SWEP.UpgradedName = "Flamelauncher"
SWEP.EnhancedClipSize = 16
SWEP.UpgradedMat = ""
SWEP.UpgradedSound = SWEP.Primary.Sound

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.exppownum = 170
SWEP.yintercept = -1
SWEP.HorizontalRecoil = 1.5
SWEP.VerticalRecoil = 5
SWEP.IronSightsPos 		= Vector( 5.15, -2, 2.6 )
SWEP.IronSightsAng 		= Vector( 0, 0, 0 )


	
	