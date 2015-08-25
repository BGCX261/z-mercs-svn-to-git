/*
So, what did I change? For starters I converted the base to using DTvars to make it more optimised
I also integrated the weapon modification system in and the use of speed based inaccuracy. I also
made the recoil more controlable when making individual sweps.

Then as time progressed I butchered this weapon base (namely the primary fire and think section)
to suit what I wanted.
*/

if (SERVER) then

	AddCSLuaFile( "shared.lua" )
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false

end

if ( CLIENT ) then

	SWEP.DrawAmmo			= true
	SWEP.DrawCrosshair		= false
	SWEP.ViewModelFOV		= 63
	SWEP.ViewModelFlip		= false
	SWEP.CSMuzzleFlashes	= true
	
	// This is the font that's used to draw the death icons
	surface.CreateFont( "halflife2", ScreenScale( 30 ), 500, true, true, "HL2KillIcons" )
	surface.CreateFont( "halflife2", ScreenScale( 60 ), 500, true, true, "HL2SelectIcons" )

end
SWEP.PrintName = "Gun!"
SWEP.Author			= "Robbis_1, Wunce"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.DrawCrosshairOnSec = false

SWEP.Primary.Sound			= Sound( "Weapon_SMG1.Single" )
SWEP.Primary.Recoil			= 1.5
SWEP.Primary.Damage			= 40
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.Delay			= 0.15

SWEP.Primary.ClipSize		= -1
SWEP.EnhancedClipSize		= 0
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"
SWEP.WasAutomatic			= SWEP.Primary.Automatic

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.exppownum = 170
SWEP.yintercept = -1
SWEP.HorizontalRecoil = 1.5
SWEP.VerticalRecoil = 3
SWEP.FullyUpgraded = false
SWEP.UpgradedName = "Upgraded "..SWEP.PrintName
SWEP.UpgradedMat = ""
SWEP.UpgradedSound = SWEP.Primary.Sound

/*---------------------------------------------------------
---------------------------------------------------------*/
function SWEP:Initialize()
	util.PrecacheSound(self.Primary.Sound) 
	if self.UpgradedSound != self.Primary.Sound then
		util.PrecacheSound(self.UpgradedSound)
	end
	self:SetWeaponHoldType( self.HoldType )

	/*
	self.Weapon:SetNetworkedBool( "Ironsights", false )
	self.Weapon:SetNetworkedBool( "Stable", false )
	self.Weapon:SetNetworkedBool( "Rapid", false )
	*/
end

function SWEP:SetupDataTables()
	self:DTVar("Bool",0,"Ironsights")
	self:DTVar("Bool",1,"Stable")
	self:DTVar("Bool",2,"Rapid")
	self:DTVar("Bool",3,"Clip")
	self:SetDTBool(0,false)
	self:SetDTBool(1,false)
	self:SetDTBool(2,false)
	self:SetDTBool(3,false)
end
/*---------------------------------------------------------
	Reload does nothing
---------------------------------------------------------*/
function SWEP:Reload()
	self.Weapon:DefaultReload( ACT_VM_RELOAD );
	self:SetIronsights( false )
end

/*---------------------------------------------------------
   
---------------------------------------------------------*/
function SWEP:Think()

if self:GetDTBool(2) and !self.Primary.Automatic then
	self.Primary.Automatic = true
end

if self:GetDTBool(3) and self.Primary.ClipSize != self.EnhancedClipSize and self.EnhancedClipSize != -1 then
	self.Primary.ClipSize = self.EnhancedClipSize
	self:Reload()
	if self:GetClass() == "cool_ak" then
		self.Primary.NumberofShots = 2
	end
end

if !self.FullyUpgraded and self:GetDTBool(1) and self:GetDTBool(2) and self:GetDTBool(3) then
 self.PrintName = self.UpgradedName
 self.FullyUpgraded = true
 --self.Weapon:SetMaterial(self.UpgradedMat)
 self.Primary.Sound = self.UpgradedSound 
end

end
/*---------------------------------------------------------
	Holster
---------------------------------------------------------*/
function SWEP:Holster( wep )

	return true
end

/*---------------------------------------------------------
	Deploy
---------------------------------------------------------*/
function SWEP:Deploy()
	if ( SERVER ) and ( self.Weapon:GetDTBool( 0 ) ) then self.Owner:CrosshairDisable() end
	return true
end

/*------------------------------------
	Incendiary ammo 
------------------------------------*/
flamedamage = DamageInfo()
			flamedamage:SetDamage( 5 )
			flamedamage:SetDamageType( DMG_DIRECT ) 
			flamedamage:SetDamageForce( Vector( 0, 0, 0 ) ) 
			
			
/*---------------------------------------------------------
	PrimaryAttack
---------------------------------------------------------*/
			
function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	
		if ( !self:CanPrimaryAttack() ) then return end 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo) 

	/*----------------------------------
	Reduction of accuracy based on speed.
	-----------------------------------*/
	local a = self.Owner:GetVelocity()
	local mag = math.sqrt((a.x * a.x) + (a.y * a.y) + (a.z *a.z))
	local degrees = math.exp(mag/self.exppownum) + self.yintercept
	
	local factor = 1
	local rapidfactor = 1
	if self.Weapon:GetDTBool(1) then
		factor = 0.5
	end
	if self.Weapon:GetDTBool(2) and self.WasAutomatic then
		rapidfactor = 0.5
	elseif self.Weapon:GetDTBool(2) and !self.WasAutomatic then
		rapidfactor = 0.75
	end
	
	
	local spreadVal = math.sin(math.Deg2Rad(degrees*0.5*factor))
	local bullet = {}

		bullet.Num = self.Primary.NumberofShots 
		bullet.Src = self.Owner:GetShootPos() 
		bullet.Dir = self.Owner:GetAimVector() 
		bullet.Spread = Vector( spreadVal , spreadVal, spreadVal) 
		bullet.Tracer = self.Primary.Tracer 
		bullet.Force = self.Primary.Force 
		bullet.Damage = self.Primary.Damage 
		
		
		//// SPECIAL DEAGLE EFFECTS ////
		if self:GetClass() == "beasty_deagle" and self.Weapon:GetDTBool(1) then
			
			local tr = self.Owner:GetEyeTrace()
			
				if self.FullyUpgraded then
					local effectdata = EffectData()
					effectdata:SetStart(tr.HitPos)
					effectdata:SetOrigin(tr.HitPos)
					effectdata:SetNormal(tr.HitNormal)
					effectdata:SetScale(1)
					
					util.Effect("fireround_effect", effectdata)
				end
				
				if SERVER and (tr.Entity:GetClass() == "npc_fastzombie" or tr.Entity:GetClass() == "npc_headcrab_fast" or tr.Entity:GetClass() == "npc_metropolice") and tr.Entity:IsValid() then
					tr.Entity:Ignite(5,0)
				elseif SERVER and !tr.HitWorld and !tr.Entity:IsPlayer() then
					timer.Create(tostring(tr.Entity)..self.Owner:Nick().."flameshot",1,5,function()
						if tr.Entity:IsValid() then
							flamedamage:SetAttacker(self.Owner or self)
							tr.Entity:TakeDamageInfo(flamedamage)
						end
					end)
				end
			
		end
		self.Owner:FireBullets( bullet )			

		
		
		
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:ShootEffects() 
	
	self:EmitSound(Sound(self.Primary.Sound)) 
	self:SetNextPrimaryFire( CurTime() + (self.Primary.Delay*rapidfactor ))
	
	local rightpunch = -math.Rand(-self.HorizontalRecoil,self.HorizontalRecoil)
	local uppunch = -math.Rand(-self.VerticalRecoil/4,self.VerticalRecoil)
	self.Owner:ViewPunch( Angle( uppunch*factor,rightpunch*factor,0 ) )

end



/*---------------------------------------------------------
	Checks the objects before any action is taken
	This is to make sure that the entities haven't been removed
---------------------------------------------------------*/
function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )

	draw.SimpleText( self.IconLetter, "HL2SelectIcons", x + wide/2, y + tall*0.2, Color( 255, 210, 0, 255 ), TEXT_ALIGN_CENTER )

end

local IRONSIGHT_TIME = 0.25

/*---------------------------------------------------------
   Name: GetViewModelPosition
   Desc: Allows you to re-position the view model
---------------------------------------------------------*/
function SWEP:GetViewModelPosition( pos, ang )

	if ( !self.IronSightsPos ) then return pos, ang end

	local bIron = self.Weapon:GetDTBool( 0 )
	
	if ( bIron != self.bLastIron ) then
	
		self.bLastIron = bIron 
		self.fIronTime = CurTime()
	
	end
	
	local fIronTime = self.fIronTime or 0

	if ( !bIron && fIronTime < CurTime() - IRONSIGHT_TIME ) then 
		return pos, ang 
	end
	
	local Mul = 1.0
	
	if ( fIronTime > CurTime() - IRONSIGHT_TIME ) then
	
		Mul = math.Clamp( (CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1 )
		
		if (!bIron) then Mul = 1 - Mul end
	
	end

	local Offset	= self.IronSightsPos
	
	if ( self.IronSightsAng ) then
	
		ang = ang * 1
		ang:RotateAroundAxis( ang:Right(), 		self.IronSightsAng.x * Mul )
		ang:RotateAroundAxis( ang:Up(), 		self.IronSightsAng.y * Mul )
		ang:RotateAroundAxis( ang:Forward(), 	self.IronSightsAng.z * Mul )
	
	
	end
	
	local Right 	= ang:Right()
	local Up 		= ang:Up()
	local Forward 	= ang:Forward()
	
	

	pos = pos + Offset.x * Right * Mul
	pos = pos + Offset.y * Forward * Mul
	pos = pos + Offset.z * Up * Mul

	return pos, ang
	
end

function SWEP:SetIronsights( b )
	if 	self:GetDTBool(0) != b then
	self:SetDTBool(0,b)
	end
end


SWEP.NextSecondaryAttack = 0
/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()

	if ( !self.IronSightsPos ) then return end
	if ( self.NextSecondaryAttack > CurTime() ) then return end
	
	bIronsights = !self.Weapon:GetDTBool( 0 )
	
	self:SetIronsights( bIronsights )
	
	self.NextSecondaryAttack = CurTime() + 0.3

end