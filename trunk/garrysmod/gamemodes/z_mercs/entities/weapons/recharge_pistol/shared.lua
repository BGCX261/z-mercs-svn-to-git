//General Settings \\ 
AddCSLuaFile( "shared.lua" ) 
SWEP.PrintName 		= "Energy Pistol" // your sweps name 
 
SWEP.Author 		= "Wunce" // Your name 
SWEP.Instructions 	= "Fire once to deliver a powerful round, hold down for a volley of weaker ones." // How do pepole use your swep ? 
SWEP.Contact 		= "YourMailAdress" // How Pepole chould contact you if they find bugs, errors, etc 
SWEP.Purpose 		= "WhatsThePurposeOfThisSwep" // What is the purpose with this swep ? 
 
SWEP.AdminSpawnable = true // Is the swep spawnable for admin 
SWEP.Spawnable 		= false // Can everybody spawn this swep ? - If you want only admin keep this false and adminsapwnable true. 
 
SWEP.ViewModelFOV 	= 64 // How much of the weapon do u see ? 
SWEP.ViewModel 		= "models/weapons/v_pistol.mdl" // The viewModel, the model you se when you are holding it-.- 
SWEP.WorldModel 	= "models/weapons/w_pistol.mdl" // The worlmodel, The model yu when it's down on the ground 
 SWEP.IconLetter		= "g"
SWEP.AutoSwitchTo 	= false // when someone walks over the swep, chould i automatectly change to your swep ? 
SWEP.AutoSwitchFrom = false // Does the weapon get changed by other sweps if you pick them up ?
 
SWEP.Slot 			= 1 // Deside wich slot you want your swep do be in 1 2 3 4 5 6 
SWEP.SlotPos = 1 // Deside wich slot you want your swep do be in 1 2 3 4 5 6 
 
SWEP.HoldType = "Pistol" // How the swep is hold Pistol smg greanade melee 
 
SWEP.FiresUnderwater = false // Does your swep fire under water ? 
 
SWEP.Weight = 5 // Chose the weight of the Swep 
 
SWEP.DrawCrosshair = false // Do you want it to have a crosshair ? 
 
SWEP.Category = "Unique" // Make your own catogory for the swep 
 
SWEP.DrawAmmo = false // Does the ammo show up when you are using it ? True / False 
 
--SWEP.ReloadSound = "sound/owningyou.wav" // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw" 
 
SWEP.Base = "weapon_ironsight_base" 
//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "weapons/stunstick/spark1.wav" // The sound that plays when you shoot :] 
SWEP.Primary.Damage = 25 // How much damage the swep is doing 
SWEP.Primary.TakeAmmo = 0 // How much ammo does it take for each shot ? 
SWEP.Primary.ClipSize = -1 // The clipsize 
SWEP.Primary.Ammo = "none" // ammmo type pistol/ smg1 
SWEP.Primary.DefaultClip = -1 // How much ammo does the swep come with `? 
SWEP.Primary.Spread = 0 // Does the bullets spread all over, if you want it fire exactly where you are aiming leave it o.1 
SWEP.Primary.NumberofShots = 1 // How many bullets you are firing each shot. 
SWEP.Primary.Automatic = true // Is the swep automatic ? 
SWEP.Primary.Recoil = 1 // How much we should punch the view 
SWEP.Primary.Delay = 0.2 // How long time before you can fire again 
SWEP.Primary.Force = 0 // The force of the shot 
//PrimaryFire settings\\
SWEP.lastfiretime = 0

SWEP.IronSightsPos 		= Vector( -6.0266, -1.0035, 3.9003 ) -- these co-ordinates were taken from Mad Cows weapons.
SWEP.IronSightsAng 		= Vector(0.5281, -1.3165, 0.8108)

--SWEP.HorizontalRecoil = -1
--SWEP.VerticalRecoil = 2
SWEP.exppownum = 120
SWEP.yintercept = 4

SWEP.UpgradedName = "RAVE!"
SWEP.EnhancedClipSize = -1
SWEP.UpgradedMat = ""
SWEP.UpgradedSound = SWEP.Primary.Sound

function getGunPosAng(GUN)
    local attachmentID=GUN:LookupAttachment("anim_attachment_RH");
    return GUN:GetAttachment(attachmentID)
end

 
//SWEP:PrimaryFire\\ 
function SWEP:PrimaryAttack() 
	--if self.lastfiretime > CurTime() + 0.3 then return end 
local speedfactor = 1
local colour = Vector(75,150,230)
local powershottime = 1
local hitpos

	if self.FullyUpgraded then
		colour = Vector(math.random(1,5)*50,math.random(1,5)*50,math.random(1,5)*50)
	end	
	
	if self.Weapon:GetDTBool( 2) then
		speedfactor = 0.5
	end	
	
	if self.Weapon:GetDTBool( 3) then
		powershottime = 0.6
	end	
	
bullet = {}
	if self.lastfiretime < CurTime() - powershottime then
		bullet.Num = self.Primary.NumberofShots 
		bullet.Src = self.Owner:GetShootPos() 
		bullet.Dir = self.Owner:GetAimVector() 
		bullet.Spread = Vector( 0.01 , 0.01, 0) 
		bullet.Tracer = 0
		bullet.Force = self.Primary.Force 
		bullet.Damage = self.Primary.Damage 
		
		local traceRes = self.Owner:GetEyeTrace()
		
	local effectdata = EffectData()
	effectdata:SetOrigin(traceRes.HitPos)
	effectdata:SetStart(getGunPosAng(self.Owner).Pos + self.Owner:GetForward()*7 + self.Owner:GetUp() * 3)
	effectdata:SetScale(1)
	effectdata:SetNormal(colour)

	util.Effect("en_pistol_effect", effectdata)
		self.Owner:FireBullets( bullet ) 
		
	else
	
	
	local a = self.Owner:GetVelocity()
	local mag = math.sqrt((a.x * a.x) + (a.y * a.y) + (a.z *a.z))
	local degrees = math.exp(mag/self.exppownum) + self.yintercept
	
	local factor = 1
	local rapidfactor = 1
	if self.Weapon:GetDTBool(1) then
		factor = 0.5
	end
  
  local spreadVal = math.sin(math.Deg2Rad(degrees*0.5*factor))
 

		bullet.Num = self.Primary.NumberofShots 
		bullet.Src = self.Owner:GetShootPos() 
		bullet.Dir = self.Owner:GetAimVector() 
		bullet.Spread = Vector(spreadVal, spreadVal, spreadVal)
		bullet.Tracer = 0
		bullet.Force = 0
		bullet.Damage = 4
		bullet.Callback = function(att, tr , dmginfo)
	local effectdata = EffectData()
	effectdata:SetOrigin(tr.HitPos)
	effectdata:SetStart(getGunPosAng(self.Owner).Pos + self.Owner:GetForward()*7 + self.Owner:GetUp() * 3)
	effectdata:SetScale(1)
	effectdata:SetNormal(colour)
	util.Effect("en_pistol_effect", effectdata)
		
	
		end
		self.Owner:FireBullets( bullet ) 
	
 
	local rightpunch = -math.Rand(-1,1)
	local uppunch = -math.Rand(0,3)
	self.Owner:ViewPunch( Angle( uppunch*factor,rightpunch*factor,0 ) )
	end
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

	self:ShootEffects() 
	self:EmitSound(Sound(self.Primary.Sound)) 
 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay*speedfactor)
	self.lastfiretime = CurTime()
end 
