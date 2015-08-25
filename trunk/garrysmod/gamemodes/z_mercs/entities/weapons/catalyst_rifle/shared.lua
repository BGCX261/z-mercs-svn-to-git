//General Settings \\ 
AddCSLuaFile( "shared.lua" ) 
SWEP.PrintName 		= "Catalyst Rifle" // your sweps name 
 
SWEP.Author 		= "Wunce" // Your name 
SWEP.Instructions 	= "Fire once at a target and wait for the fireworks." // How do pepole use your swep ? 
SWEP.Contact 		= "YourMailAdress" // How Pepole chould contact you if they find bugs, errors, etc 
SWEP.Purpose 		= "WhatsThePurposeOfThisSwep" // What is the purpose with this swep ? 
 
SWEP.AdminSpawnable = true // Is the swep spawnable for admin 
SWEP.Spawnable 		= false // Can everybody spawn this swep ? - If you want only admin keep this false and adminsapwnable true. 
 
SWEP.ViewModelFOV 	= 64 // How much of the weapon do u see ? 
SWEP.ViewModel 		= "models/weapons/v_irifle.mdl" // The viewModel, the model you se when you are holding it-.- 
SWEP.WorldModel 	= "models/weapons/w_irifle.mdl" // The worlmodel, The model yu when it's down on the ground 
 
SWEP.AutoSwitchTo 	= false // when someone walks over the swep, chould i automatectly change to your swep ? 
SWEP.AutoSwitchFrom = false // Does the weapon get changed by other sweps if you pick them up ?
 
SWEP.Slot 			= 5 // Deside wich slot you want your swep do be in 1 2 3 4 5 6 
SWEP.SlotPos = 5// Deside wich slot you want your swep do be in 1 2 3 4 5 6 
 
SWEP.HoldType = "ar2" // How the swep is hold Pistol smg greanade melee 
 
SWEP.FiresUnderwater = false // Does your swep fire under water ? 
 
SWEP.Weight = 5 // Chose the weight of the Swep 
 
SWEP.DrawCrosshair = false // Do you want it to have a crosshair ? 
 
SWEP.Category = "Unique" // Make your own catogory for the swep 
 
SWEP.DrawAmmo = true // Does the ammo show up when you are using it ? True / False 
 
SWEP.ReloadSound = "sound/owningyou.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.base = "weapon_base" 
//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "weapons/mortar/mortar_explode1.wav" // The sound that plays when you shoot :] 
SWEP.Primary.Damage = 1 // How much damage the swep is doing 
SWEP.Primary.TakeAmmo = 1 // How much ammo does it take for each shot ? 
SWEP.Primary.ClipSize = 1 // The clipsize 
SWEP.Primary.Ammo = "RPG_Round" // ammmo type pistol/ smg1 
SWEP.Primary.DefaultClip = 2 // How much ammo does the swep come with `? 
SWEP.Primary.Spread = 0 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it o.1 
SWEP.Primary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = false // Is the swep automatic ? 
SWEP.Primary.Recoil = 5 // How much we should punch the view 
SWEP.Primary.Delay = 4 // How long time before you can fire again 
SWEP.Primary.Force = 1 // The force of the shot 
//PrimaryFire settings\\
SWEP.looprar = 0
SWEP.Deathents = {}
SWEP.increm = 0
SWEP.activetargets = 0
//SWEP:Initialize\\ 
function SWEP:Initialize() 
	util.PrecacheSound(self.Primary.Sound) 
	--util.PrecacheSound(self.Secondary.Sound) 
        self:SetWeaponHoldType( self.HoldType )
end 
//SWEP:Initialize\\
 
//SWEP:PrimaryFire\\ 
function SWEP:PrimaryAttack() 
	if ( !self:CanPrimaryAttack() ) then return end 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo) 

	if timer.IsTimer("CatalystDeath") then
	timer.Stop("CatalystDeath")
	self.looprar = 0
	self.increm = 0
	end
local bullet = {}

		bullet.Num = self.Primary.NumberofShots 
		bullet.Src = self.Owner:GetShootPos() 
		bullet.Dir = self.Owner:GetAimVector() 
		bullet.Spread = Vector( 0 , 0, 0) 
		bullet.Tracer = 1
		--bullet.TracerName = "StriderTracer"
		bullet.Force = self.Primary.Force 
		bullet.Damage = self.Primary.Damage 
		--bullet.AmmoType = self.Primary.Ammo 
		self.Owner:FireBullets( bullet )			
					

	--now do a regular trace and hope for the best
	local trace = util.GetPlayerTrace( self.Owner)
local tr=util.TraceLine(trace)
if tr.Entity then
print(tr.Entity)
end
		if tr.Hit and tr.HitNonWorld and tr.Entity:IsPlayer() then

		elseif tr.Hit and tr.HitNonWorld and !tr.Entity:IsPlayer() and (SERVER) then
					if !self.Owner.Deathents then
					self.Owner.Deathents = {}
					end
					
					self.Owner.increm = 1
					self.Owner.Deathents[self.increm] = tr.Entity
					self.Owner.looprar = 0
					self.Owner.ThisRound = {}
					
					timer.Create("CatalystDeath",0.1,0,CatalystEffect,self.Owner)

	end
 
	local rnda = self.Primary.Recoil * -1 
	local rndb = self.Primary.Recoil * math.random(-1, 1) 
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

	self:ShootEffects() 
	
	 
	self:EmitSound(Sound(self.Primary.Sound)) 
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:Reload()

end 
 
function SWEP:SecondaryAttack() 

end 

	function SWEP:Reload()
		self.Weapon:DefaultReload( ACT_VM_RELOAD ) //animation for reloading
	end
