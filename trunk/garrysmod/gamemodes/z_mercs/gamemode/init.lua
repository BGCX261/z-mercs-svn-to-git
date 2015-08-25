/*	_                  _
	\\       /\       //
	 \\     //\\     //
	  \\   //  \\   //
	   \\_//    \\_//
	    \_/      \_/ u n c e  A d d o n s
*/

include( 'shared.lua' )
require "glon"

/*---------------------------------------------
	SUBMODES: Put your submode here so
			  that it can be found easily
			  
			  
	Current Sub-Mode Vars:
		- DensityOverride (float): A multiplier for the amount of NPC's. Overrides SHAID.
		
		- current_submode (string): The name of the submode, must be assigned a value when mode starts ( and set to nil when its over )
		
		- single_life (boolean): When players die, they won't respawn.
		
		- ammo_drop (boolean): Should NPC's drop ammo?
		
		- nearobjective (Vector)

---------------------------------------------*/
concommand.Add("SubMode", function(ply,c,a)
local arg = tonumber(a[1])

	if arg == 1 then Z_Ops_Start() end


end)	



// Z_OPS //
concommand.Add("Z_OPS_EXTRACTION", function (ply, c, a)-- SO players get to choose their own extraction point

	local pos = ply:GetPos()
	local ang = ply:GetForward()
	
	local array = {}
	array[1] = pos
	array[2] = ang

		local map = string.gsub(game.GetMap(),"_","q")
		local Textfile = string.format("WunceFiles/%szops.txt",map )

file.Write( Textfile, glon.encode( array ) )
end)

function Z_Ops_Start()

print("Loading Submode-Specific Points") -- Here I load the extraction location.

		local map = string.gsub(game.GetMap(),"_","q")
		local Textfile = string.format("WunceFiles/%szops.txt",map )

		if !file.Exists( Textfile ) then
		print("ERROR: The file for this sub-mode is missing.")

		else 
		ZOPS = glon.decode( file.Read( Textfile ) )

		end
	
						umsg.Start("Timer", nil) -- Probably could be sent with the one above.
						umsg.Float(CurTime() + 20)
						umsg.End()
		


	current_submode = "Z_Operations"
	single_life = true
	ammo_drop = false
	DensityOverride = 0.6
	
	if 	ExplosiveCharge and ExplosiveCharge:IsValid() then
	ExplosiveCharge:Remove()
	end
	
	for k, ply in pairs(player.GetAll()) do
		ply:Spawn()
		ply:StripWeapons()
		ply:StripAmmo()
	end

	local OffenseBox = ents.Create("class_box")
			OffenseBox.Classy = 1
			OffenseBox:SetPos(droplocation + Vector(50,300,0) )
			OffenseBox:Spawn()
			OffenseBox:Activate()
			
	local SupportBox = ents.Create("class_box")
			SupportBox.Classy = 2
			SupportBox:SetPos(droplocation +Vector(0,300,0))
			SupportBox:Spawn()
			SupportBox:Activate()
			
	local ImpactBox  = ents.Create("class_box")
			ImpactBox.Classy = 3
			ImpactBox:SetPos(droplocation + Vector(-50,300,0) )
			ImpactBox:Spawn()
			ImpactBox:Activate()
			
	timer.Simple(20,function()
	
		umsg.Start("NEWOBJ", ply)
		umsg.String(glon.encode( "The Ion Cannon Beacon is located nearby. Access it." ))
		umsg.End()
		
	for k, NPC in pairs(ents.FindByClass("npc*")) do
		NPC:Remove()
	end
		
	OffenseBox:Remove()
	SupportBox:Remove()
	ImpactBox:Remove()
	
	for k, ply in pairs(player.GetAll()) do
	
		ply:SetPos(ZOPS[1] - ZOPS[2]*300 + Vector(math.random(-300,300),math.random(-300,300),100 ) )
		
	end
	

	
		local biggest = 0
		local letter = 0
		
			for q=1,ObjNum do
				local a = ObjPoint[q]-ZOPS[1] 
				local mag = math.sqrt(a.x*a.x + a.y*a.y + a.z*a.z)
					if mag > biggest then
						biggest = mag
						letter = q
					end
			end
				Destination = ObjPoint[letter]	
				tmpvec = Destination
						--umsg.Start("ObjMarker", nil)
						--umsg.Vector(Destination + Vector(0,0,100))
						--umsg.End()
		
		nearobjective = Destination
		
		local ImpactBox  = ents.Create("big_ass_beacon")
			ImpactBox:SetPos(Destination)
			ImpactBox:Spawn()
			ImpactBox:Activate()
	--SET PLAYERS AT MY SPECIAL INS/EXTRACTION POINT
	--SPAWN OBJECTIVE ONE
	
	
				DoctorC = ents.Create("npc_kleiner") 
				DoctorC:SetPos(Destination+Vector(0,0,10)) 
				DoctorC:SetColor(0,0,0,0)
				DoctorC:SetMaxHealth(100)
				DoctorC:Spawn() 
				DoctorC:SetHealth(5000) -- DON'T FORGET TO FREEZE HIM
				OVERRIDE = DoctorColossus
	end)
			
end

function Z_Ops_Finish()
DensityOverride = 1
current_submode = nil
single_life = false
ammo_drop = true
nearobjective = nil
if CHOPPA and CHOPPA:IsValid() then
CHOPPA:Remove()
end
CHOPPA = nil

OVERRIDE = nil
end


function Z_Ops_first_obj_done()
DensityOverride = 2
		umsg.Start("NEWOBJ", ply)
		umsg.String(glon.encode( "Defend the beacon while the satillite aligns." ))
		umsg.End()
		DoctorC:SetHealth(50)
		sweettime = CurTime() + 90
						umsg.Start("Timer", nil)
						umsg.Float(CurTime() + 90)
						umsg.End()
		timer.Create("CheckforBeacon",0.5,0,function()
		
		if DoctorC:IsValid() and sweettime <= CurTime() then
			Z_Ops_second_obj_done()
			timer.Stop("CheckforBeacon")
		elseif !DoctorC:IsValid() then
		Z_Ops_Finish()
		timer.Stop("CheckforBeacon")
			umsg.Start("OBJFAILURE", ply)
			umsg.String(glon.encode( "Beacon destroyed." ))
			umsg.End()
		else
			DoctorC:SetLastPosition(tmpvec)
			DoctorC:SetSchedule(SCHED_FORCED_GO_RUN)
		end
		end)
		
end

function Z_Ops_second_obj_done()
OVERRIDE = nil
DensityOverride = 1.2
nearobjective = ZOPS[1]
		umsg.Start("OBJSUCCESS", ply)
		umsg.String(glon.encode( "Satillite aligned. Chopper ready for extraction." ))
		umsg.End()
		timer.Simple(60,function()
		
	local ent = ents.Create("ic_huge")
		ent:SetPos(tmpvec)
		ent:SetVar("Owner",ent)
		ent:SetVar("Scale",2)
		ent:Spawn()
		ent:Activate()
		tmpvec = nil
		CHOPPA.move = CurTime()
		end)
		
			timer.Create("ALLABOARD",0.2,25,function()
				 for k, ply in pairs(ents.FindInBox( CHOPPA:GetPos() + Vector(-200,-200,-50), CHOPPA:GetPos() + Vector(200,200,100) )) do -- also fix them to the choppa
					 if ply:IsPlayer() and !ply.AlreadyRagdolled then
						ply:GodEnable()
						ply.Cash = ply.Cash + 10
					 end
				 end
			end)
			
		timer.Simple(110,function()
		Z_Ops_final_obj_done()
		end)
		
		CHOPPA = ents.Create("extraction_choppa");
	CHOPPA:SetPos(ZOPS[1]) --ent is returning NULL
	CHOPPA:SetAngles(ZOPS[2]:Angle())
	CHOPPA:Spawn()
	CHOPPA:Activate()
		bossspawn = true
end

function Z_Ops_final_obj_done()
Z_Ops_Finish()
-- give alive players cash
end


/* Just in case I feel like making an NPC shoot something strange...
self.target1 = ents.Create("npc_bullseye")   
		self.target1:SetPos( self.Entity:GetPos() + ( self.Entity:GetForward() * 80 ) + ( self.Entity:GetUp() * 15 ) )
		self.target1:SetParent(self.Entity)  
		self.target1:SetKeyValue("health","9999")  
		self.target1:SetKeyValue("spawnflags","256") 
		self.target1:SetNotSolid( true )  
		self.target1:Spawn()  
		self.target1:Activate() 
*/

 


/*------------------------------------------
	GAMEMODE SPECIFIC STUFF
------------------------------------------*/

function GM:PlayerInitialSpawn(ply)
ply:SetTeam(2)
local Textfile = string.format("WunceFiles/%scash.txt",ply:UniqueID())
if !file.Exists( Textfile ) then
ply.Cash = 200
ply.Altruism = 250
ply.TotalKills = 0
ply.ObjStrikeRate = 0
			umsg.Start("call_help", ply)
			umsg.End()
else
local dataarray = string.Explode(",",file.Read(Textfile))
ply.Cash = tonumber(dataarray[1])
ply.Altruism = tonumber(dataarray[2])
ply.TotalKills = tonumber(dataarray[3])
ply.ObjStrikeRate = tonumber(dataarray[4])
end
sendmoney(ply, ply.Cash)
ply.killsection = 0

end

function GM:PlayerDeathThink( pl )

    pl.DeathTime = pl.DeathTime or CurTime()
    local timeDead = CurTime() - pl.DeathTime

	local everyonedead = true
	for k, ply in pairs(player.GetAll()) do
		if ply:Alive() then everyonedead = false end
	end
	
	if everyonedead and single_life then
		Z_Ops_Finish()
	end
	
	// No lives means no spawn
	if single_life then
		return
	end
	
	
    // Force respawn
    if timeDead > 15 then
        pl:Spawn()
        return
	end

    // We're between min and max death length, player can press a key to spawn.
    if ( pl:KeyPressed( IN_ATTACK ) || pl:KeyPressed( IN_ATTACK2 ) || pl:KeyPressed( IN_JUMP ) ) then
        pl:Spawn()
    end
    
end


timer.Create("LoadData", 3 , 1 , function() -- every two minutes all of your data is saved :D
	local map = string.gsub(game.GetMap(),"_","q")
	local Textfile = string.format("WunceFiles/%sshop.txt",map )
	SHAID = true
	BootTime = CurTime()
if !file.Exists( Textfile ) then
	print("NO PURCHASE DROP LOCATION FOR THIS MAP")
else
	droplocation = glon.decode( file.Read( Textfile ) )

end
	
end)

function GM:PlayerCanPickupWeapon( ply, entity )
if (!entity.plyspawner or entity.plyspawner == ply) and entity:GetClass() != "weapon_smg1" and entity:GetClass() != "weapon_stunstick" and ply:Team() != 1 then
	entity.Dropped = false
	return true
elseif entity.plyspawner and entity.plyspawner.wepsharing == true and  ply:Team() != 1 then
	entity.Dropped = false
	return true
else
	return false
end
end



timer.Create("AutoOpt", 3 , 0 , function()
if droplocation then
for k, ply in pairs(player.GetAll()) do
ply.optin = true
end
for k, ent in pairs(ents.FindInSphere( droplocation, 1000 )) do
if ent:IsPlayer() then ent.optin = false end
if ent:IsNPC() and ent:GetClass() != "npc_kleiner" then ent:TakeDamage(1000, ent)

	elseif ent:GetClass() == "npc_kleiner" and CurObj == "Escort" then
	ent:Remove()
		for k, ply in pairs(player.GetAll()) do
			CurObj = nil
			ply.Cash = ply.Cash + 250
			sendmoney(ply, ply.Cash)
							umsg.Start("OBJSUCCESS", ply)
							umsg.String(glon.encode( "Kleiner safely made it to the buy zone." ))
							umsg.End()
							umsg.Start("ObjMarker", nil)
							umsg.Vector(Vector(0,0,0))
							umsg.End()
			ObjStrRte(ply, 1)
		end
		
		NextObjTime = CurTime() + 120
	end
	
	
end
end
end)

function AutoOptOut(ply)
ply.optin = false
end
hook.Add("PlayerSpawn", "AutoOptOut", AutoOptOut)

timer.Create("SaveData", 120 , 0 , function() -- every two minutes all of your data is saved :D
for k,ply in pairs(player.GetAll()) do
SavePlayerStats(ply)
ply:ChatPrint("Cash and altruism saved")
end
end)

function SavePlayerStats(ply)
file.Write(string.format("WunceFiles/%scash.txt",ply:UniqueID()), string.format("%i,%i,%i,%G", ply.Cash, ply.Altruism,ply.TotalKills,ply.ObjStrikeRate))
end

function GM:PlayerTraceAttack( ply, dmginfo, dir, trace ) 
 
 	if ( SERVER ) then 
 		MYLIMBS( ply, trace.HitGroup, dmginfo ) 
 	end 
 
 	return false 
 end

function GM:PlayerLoadout( ply ) --Thanks to the wiki for this section. It assigns each body part health
	if ply.AlreadyRagdolled == false then
	ply.hitgroups = {}
	for group = 0,10 do
		if group == HITGROUP_LEFTARM or group == HITGROUP_RIGHTARM or group == HITGROUP_LEFTLEG or group == HITGROUP_RIGHTLEG then
			ply.hitgroups[group] = maxlimb[group]
		elseif group == HITGROUP_CHEST then
			ply.hitgroups[group] = maxlimb[group]
		elseif group == HITGROUP_HEAD then
			ply.hitgroups[group] = maxlimb[group]
		end
	end
	if ply:Team() != 1 then

	ply:Give("basic_pistol")
	ply:RemoveAllAmmo()
	ply:GiveAmmo( 96 , "pistol" )
	end
	else

		ply:StripWeapons()
		ply:RemoveAllAmmo()
		ply:SetSuppressPickupNotices ( true ) -- thank you to the guy who made Ragmod for this. I didn't even know it existed
		
		for k, q in pairs(ply.gunn) do
		ply:Give(q.Class)
		end
		
		for k, wep in pairs (ply:GetWeapons()) do -- AMMO AND UPGRADES ARE NOW SAVED 7/03/2011
			wep:SetClip1(ply.gunn[k].CurrentClip)
			wep:SetClip2(0)
			wep:SetDTBool(1, ply.gunn[k].upgrade1)
			wep:SetDTBool(2, ply.gunn[k].upgrade2)
			wep:SetDTBool(3, ply.gunn[k].upgrade3)
		end
		
		timer.Create(string.format( "AmmoSet:%s", ply ),0.1 , 1, function()
		for k, q in pairs(ply.SAmmo) do
		
			ply:SetAmmo( q , ply.AmmoName[k] )
			if table.HasValue(ply:GetWeapons(),ply.curgunn) then
			ply:SelectWeapon( ply.curgunn:GetClass() )
			end
		end
		end)
	
	ply:SetSuppressPickupNotices ( false )
	ply.AlreadyRagdolled = false
end
end

		function GM:ShowSpare1(ply)
			umsg.Start("call_buymenu", ply)
			umsg.End()
		end
		
		function GM:ShowSpare2(ply)
			umsg.Start("call_specmenu", ply)
			umsg.End()
		end

		function GM:ShowHelp(ply)
			umsg.Start("call_help", ply)
			umsg.End()
		end
		
		function GM:ShowTeam(ply)
			umsg.Start("call_team", ply)
			umsg.End()
		end

			function ChangePlayersTeam(ply, com, argument)
			local arg = tonumber(argument[1])
			
				if arg == 1 then
					if team.NumPlayers(1) == 0 then
					ply:SetTeam(arg)
					ply:Kill()
					else
					ply:ChatPrint("There is already a Co-Ordinator")
					end
				elseif arg == 2 then
				ply:SetTeam(arg)
				elseif arg == 3 then
				ply:SetTeam(arg)
				end
			
			end
			concommand.Add("changeteamto", ChangePlayersTeam)			
			
	function disablemovement(ply, c, a) -- CURRENTLY IF YOUR LEGS ARE DAMAGED WHEN IN CO_ORD MODE YOU WILL START WALKING AROUND!!!
	local arg = tonumber(a[1])
	if arg == 0 then
	LegDamage(ply, ply.hitgroups[HITGROUP_LEFTLEG] , ply.hitgroups[HITGROUP_RIGHTLEG] )
	else
		ply:SetWalkSpeed(1)
		ply:SetRunSpeed(2)
		print("Movement disabled")
	end
	end
	concommand.Add("stopmoving", disablemovement)	
	
	function retrievestats(ply, c, a)
		for k, friend in pairs(player.GetAll()) do
			if friend:Nick() == a[1] then
			
						umsg.Start("STATISTIC", ply)
				umsg.Short(friend.Altruism)
				umsg.Float(friend.ObjStrikeRate)
				umsg.Long(friend.TotalKills)
						umsg.End()
						
			end
		end
	end
	concommand.Add("retrievestats", retrievestats)
			
function InterestActivation(ply, c , arg)
for k, ent in pairs(ents.FindInSphere(ply:GetPos(),100)) do
	
	if ent:GetClass() == "inferno_tower" then

		if arg[1] == "A" then

			ent.IFF = true
			AltUp(ply, ply.Altruism ,14)
			timer.Create("inferno"..tostring(ent),20,0 , function()
				for k, ent in pairs(ents.FindInSphere(ent:GetPos(),2000)) do
				if math.random(1,10) > 4 and ent:IsNPC() and ent:GetClass() != "npc_kleiner" then ent:Ignite(10,1) end
				end
			end)
			
		elseif arg[1] == "B" then
			ent.IFF = false
			AltDown(ply, ply.Altruism ,10)
			timer.Create("inferno"..tostring(ent),12,0 , function()
				for k, ent in pairs(ents.FindInSphere(ent:GetPos(),2000)) do
					if ent:GetClass() == "npc_fastzombie" or ent:GetClass() == "npc_headcrab_fast" then
					ent:Ignite(10,0)
					elseif ent:IsPlayer() and ent != ply and math.random(1,5) == 1 then
					ent:Ignite(10,0)
					elseif ent:IsNPC() then
					ent:TakeDamage(25)
					end
				end
			end)
			
		end
	elseif ent:GetClass() == "turret_base" then
	
			if arg[1] == "A" then

			ent.IFF = true
			AltUp(ply, ply.Altruism ,8)
			
			local barrel = ents.Create("turret_barrel")
			barrel:SetAngles(Angle(-90,0,0))
			barrel:SetPos(ent:GetPos() + Vector(0,0,25) )
			barrel:Spawn()
			barrel:Activate()
			ent.barrel = barrel
			timer.Create("turret"..tostring(ent),1,0 , function()
			local closest = NULL
			local closestdist = 1500
			
				for k, npc in pairs(ents.FindByClass("npc*")) do
					local a =  npc:GetPos() - ent:GetPos()
					local dist = math.sqrt(a.x*a.x + a.y*a.y + a.z*a.z)
					
					if dist < closestdist and npc:GetClass() != "npc_kleiner" then
						local tracedata = {}
						tracedata.start = ent:GetPos()
						tracedata.endpos = npc:GetPos()
						tracedata.filter = ent
						tracedata.mask = SOLID_BRUSHONLY
						local tr = util.TraceLine(tracedata)
							if !tr.HitWorld and !tr.Entity:IsPlayer() then
							closestdist = dist
							closest = npc
							end
					end
				end
				
			if closest != NULL then
			local dirvec = closest:GetPos() - ent:GetPos() 
			local UpAngle = dirvec:Angle():Up():Angle() 
			barrel:SetLocalAngles( UpAngle )
			barrel:SetPos(ent:GetPos() + Vector(0,0,25) + dirvec:Normalize()*50)
			bullet = {}
bullet.Num=1
bullet.Src=barrel:GetPos() - barrel:GetAngles():Up()*15
bullet.Dir= -barrel:GetAngles():Up()
bullet.Spread=Vector(0,0,0)
bullet.Tracer=1	
bullet.Force=2
bullet.Damage=15
 
ply:FireBullets(bullet)
barrel:EmitSound("weapons/357/357_fire3.wav")
			end
			
			
				end)
			
		elseif arg[1] == "B" then
			ent.IFF = false
			AltDown(ply, ply.Altruism ,15)
			
			local barrel = ents.Create("turret_barrel")
			barrel:SetAngles(Angle(-90,0,0))
			barrel:SetPos(ent:GetPos() + Vector(0,0,30) )
			barrel:Spawn()
			barrel:Activate()
			ent.barrel = barrel
			
			timer.Create("turret"..tostring(ent),0.5,0 , function()
			local closest = NULL
			local closestdist = 1500
			
				for k, npc in pairs(ents.FindByClass("npc*")) do
					local a =  npc:GetPos() - ent:GetPos()
					local dist = math.sqrt(a.x*a.x + a.y*a.y + a.z*a.z)
					
					if dist < closestdist then
						local tracedata = {}
						tracedata.start = ent:GetPos()
						tracedata.endpos = npc:GetPos()
						tracedata.filter = ent
						tracedata.mask = SOLID_BRUSHONLY
						local tr = util.TraceLine(tracedata)
							if !tr.HitWorld then
							closestdist = dist
							closest = npc
							end
					end
				end
				
			if closest != NULL then
			local dirvec = closest:GetPos() - ent:GetPos() 
			local UpAngle = dirvec:Angle():Up():Angle() 
			barrel:SetLocalAngles( UpAngle )
			barrel:SetPos(ent:GetPos() + Vector(0,0,25) + dirvec:Normalize()*50)
			bullet = {}
bullet.Num=1
bullet.Src=barrel:GetPos() - barrel:GetAngles():Up()*15
bullet.Dir= -barrel:GetAngles():Up()
bullet.Spread=Vector(0,0,0)
bullet.Tracer=1	
bullet.Force=2
bullet.Damage=15
 
barrel:FireBullets(bullet)
barrel:EmitSound("weapons/357/357_fire3.wav")
			end
			
			
				end)
		
	end
end	
end
end
concommand.Add("Choice", InterestActivation)	
		
		function sendmoney(ply, cash)
				umsg.Start("rmoney", ply)
				umsg.Float(cash)
				umsg.End()
		end
		

		function AltUp(ply, curalt ,olddiv)
		local divisor = olddiv*10
			local newalt = math.Round(curalt + ((1000 - curalt)/divisor))
			ply:ChatPrint(string.format("Altruism +%i",newalt-curalt))
			ply.Altruism = newalt
			ply:SetDeaths(ply.Altruism)
		end

		function AltDown(ply, curalt ,olddiv)
		local divisor = olddiv*10
			local newalt = math.Round(curalt -(curalt/divisor))
			ply:ChatPrint(string.format("Altruism -%i",curalt-newalt))
			ply.Altruism = newalt
			ply:SetDeaths(ply.Altruism)
		end
		
		timer.Create("clipsend",0.5,0,function()
		
			for k, ply in pairs(player.GetAll()) do
				if ply.lasbox == false and ply:Alive() and !ply.AlreadyRagdolled then
				
					local RS = RecipientFilter()
					RS:AddPVS(ply:GetPos())

					umsg.Start( "ClipSend", RS)
						umsg.Short( ply:UserID() )
						umsg.Long( ply:GetActiveWeapon():Clip1() )
					umsg.End()
					
				end
			end
		
		end)
		
		
function shoppingtrolley(ply, c, a) 
	local tracedata = {}
	tracedata.start = ply:GetShootPos()
	tracedata.endpos = ply:GetShootPos() + ( ply:GetAimVector() * 50000 )
	tracedata.filter = ply
	local trace = util.TraceLine( tracedata )
		if trace.HitWorld then
		droplocation = trace.HitPos + Vector(0,0,10)
		
			local map = string.gsub(game.GetMap(),"_","q")
			local Textfile = string.format("WunceFiles/%sshop.txt",map )
			file.Write( Textfile, glon.encode( droplocation ) )

		end
	
	
end
concommand.Add("SHAID_purchase_drop_location", shoppingtrolley)
		
function spreadthelove(ply, com ,arg)
ply.wepsharing = !ply.wepsharing
ply:ChatPrint("Weapon Sharing: "..tostring(ply.wepsharing))
end
concommand.Add("sh_wepsharing", spreadthelove)

	
		
function buy_AK(ply, c, a)
buysomething(ply,120, "cool_ak")
end
concommand.Add("buy_ak", buy_AK)

		function buy_deagle(ply, c, a)
		buysomething(ply,200, "beasty_deagle")
		end
		concommand.Add("buy_deagle", buy_deagle)

function buy_shottie(ply, c, a)
buysomething(ply,100, "basic_shottie")
end
concommand.Add("buy_shottie", buy_shottie)

		function buy_AK_ammo(ply, c, a)
		buysomething(ply,15, "ammo_box_smg")
		end
		concommand.Add("buy_AK_ammo", buy_AK_ammo)

function buy_Deagle_ammo(ply, c, a)
buysomething(ply,25, "ammo_box_magnum")
end
concommand.Add("buy_Deagle_ammo", buy_Deagle_ammo)

		function buy_Shottie_ammo(ply, c, a)
		buysomething(ply,20, "ammo_box_shotgun")
		end
		concommand.Add("buy_Shottie_ammo", buy_Shottie_ammo)

function buy_FAS(ply, c, a)
buysomething(ply,40, "first_aid_spray")
end
concommand.Add("buy_FAS", buy_FAS)

	function buy_shield_module(ply, c, a)
	buysomething(ply,300, "shield_module")
	end
	concommand.Add("buy_shield_module", buy_shield_module)

function buy_clip_vest(ply, c, a)
buysomething(ply,150, "clip_vest")
end
concommand.Add("buy_clip_vest", buy_clip_vest)

		function buy_en_pistol(ply, c, a)
		buysomething(ply,200, "recharge_pistol")
		end
		concommand.Add("buy_en_pistol", buy_en_pistol)

function buy_Cat_Rifle(ply, c, a)
buysomething(ply,175, "catalyst_rifle")
end
concommand.Add("buy_Cat_Rifle", buy_Cat_Rifle)

	function buy_Cat_ammo(ply, c, a)
	buysomething(ply,30, "ammo_box_cat")
	end
	concommand.Add("buy_Cat_ammo", buy_Cat_ammo)

function buy_Mach(ply, c, a)
buysomething(ply,240, "beasty_machinegun")
end
concommand.Add("buy_Mach", buy_Mach)


	function buy_Mach_ammo(ply, c, a)
	buysomething(ply,40, "ammo_box_mach")
	end
	concommand.Add("buy_Mach_ammo", buy_Mach_ammo)

function buy_Line_Shottie(ply, c, a)
buysomething(ply,220, "line_shottie")
end
concommand.Add("buy_Line_Shottie", buy_Line_Shottie)

	function buy_TriLMG(ply, c, a)
	buysomething(ply,300, "special_machinegun")
	end
	concommand.Add("buy_TriLMG", buy_TriLMG)

function buy_fheal(ply, c, a)
buysomething(ply,100, "full_heal")
end
concommand.Add("buy_fheal", buy_fheal)	
	
	function buy_gmask(ply, c, a)
	buysomething(ply,60, "gas_mask")
	end
	concommand.Add("buy_gmask", buy_gmask)	

function buy_wepstab(ply, c, a)
buysomething(ply,75, "weapon_stabiliser")
end
concommand.Add("buy_wepstab", buy_wepstab)
	
	function buy_bpistol_ammo(ply, c, a)
	buysomething(ply,10, "ammo_box_pistol")
	end
	concommand.Add("buy_bpistol_ammo", buy_bpistol_ammo)

function buy_holo_info(ply, c, a)
buysomething(ply,100, "holo_projector")
end
concommand.Add("buy_holo_info", buy_holo_info)
	
	function buy_rapid(ply, c, a)
	buysomething(ply,75, "rapid_fire")
	end
	concommand.Add("buy_rapid", buy_rapid)
	
function buy_nadelauncher(ply, c, a)
buysomething(ply,200, "grenade_launcher")
end
concommand.Add("buy_nade_launcher", buy_nadelauncher)
	
	function buy_nades(ply, c, a)
	buysomething(ply,40, "ammo_box_grenade")
	end
	concommand.Add("buy_Nade_ammo", buy_nades)

function buy_clipen(ply, c, a)
buysomething(ply,50, "clip_enhancer")
end
concommand.Add("buy_clipen", buy_clipen)	
	
function buysomething(ply, cost, entname)
local num = 0

if ply:Team() == 1 then cost = cost/2 end -- half price for co-ordinators


for k, ent in pairs(ents.GetAll()) do
	if ent.plyspawner == ply and (ent.Dropped != false) then
		num = num + 1
	elseif (ent:GetClass() == "weapon_smg1" or ent:GetClass() == "weapon_stunstick") and ent:GetOwner() == NULL then
		ent:Remove()
	end
end

if droplocation and ply.Cash >= cost and num < 5 then
	local ent = ents.Create(entname)
	
	if SUPPLYDROP then
		ent:SetPos(SUPPLYDROP:GetPos())
	else
		ent:SetPos(droplocation)
	end
	
	ent.plyspawner = ply
	ent:Spawn()
	ent.Dropped = true
	ent:Activate()
	
	local phys = ent:GetPhysicsObject()
		
		if phys:IsValid() then
		phys:AddVelocity(Vector(0,0,100))
		end
	
	
	ply.Cash = ply.Cash - cost
	SavePlayerStats(ply)
	sendmoney(ply, ply.Cash)
	
timer.Simple(20,function() -- don't pick it up, get a refund
	if ent:IsValid() and ent.Dropped then
		ent:Remove()
		if ply:IsValid() then
			ply.Cash = ply.Cash + cost
			sendmoney(ply, ply.Cash)
		end
	end
end)
	
elseif droplocation and num < 5 then
ply:ChatPrint("Don't touch what you can't afford!")
elseif droplocation and num >= 5 then
ply:ChatPrint("Pick up some of your purchases before buying more.")
else
ply:ChatPrint("No purchase drop location. Ask an admin to create one.")
end
end

function CashforKills(NPC, killer, weap)
	if killer.optin and killer:IsPlayer() then
	
		if NPC:GetClass() == "npc_headcrab" or NPC:GetClass() == "npc_headcrab_fast" then 
		killer.Cash = killer.Cash + 10
		sendmoney(killer, killer.Cash)
		
		elseif NPC:GetClass() == "npc_headcrab_black" or NPC:GetClass() == "npc_antlion_worker" then
		killer.Cash = killer.Cash + 15
		sendmoney(killer, killer.Cash)

		elseif NPC:GetClass() == "npc_antlionguard" then
		killer.Cash = killer.Cash + 150
		sendmoney(killer, killer.Cash)
		
		elseif NPC:GetClass() == "npc_poisonzombie" or NPC:GetClass() == "npc_hunter" then
		killer.Cash = killer.Cash + 50
		sendmoney(killer, killer.Cash)
		
		else		
		killer.Cash = killer.Cash + 7
		sendmoney(killer, killer.Cash)
		
		end
end	
	if NPC:GetClass() == "npc_kleiner" then
						umsg.Start("SlowMotion", nil) 
						umsg.Bool(true)
						umsg.End()
						game.ConsoleCommand("host_timescale 0.25\n")
						timer.Simple(3,function()
						umsg.Start("SlowMotion", nil) 
						umsg.Bool(false)
						umsg.End()
						game.ConsoleCommand("host_timescale 1\n")
							end)
	end
end		
hook.Add("OnNPCKilled", "CashforKills", CashforKills)











/*
|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
|||||Thank You For Downloading|||||||||||||||||||||||||||||||||||||||
||||||||||||||||||||This is another Wunce addon||||||||||||||||||||||
|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
*/
util.PrecacheSound("vo/npc/male01/pain08.wav") --I'll add more later
util.PrecacheSound("vo/npc/male01/moan04.wav")
util.PrecacheSound("items/suitchargeno1.wav")
util.PrecacheSound("weapons/357/357_fire3.wav")
Thruster_Sound = Sound("PhysicsCannister.ThrusterLoop")
-- BASICALLY if you want to change the health of each limb, here is where to do it. It will screw stuff up (ie speed) so don't do it
maxlimb = {}
for group = 0,10 do
		if group == HITGROUP_LEFTARM or group == HITGROUP_RIGHTARM or group == HITGROUP_LEFTLEG or group == HITGROUP_RIGHTLEG then
			maxlimb[group] = 25
		elseif group == HITGROUP_CHEST then
			maxlimb[group] = 60
		elseif group == HITGROUP_HEAD then
			maxlimb[group] = 10
		end
	end

	
	
	
function ResetValues(ply)
if ply.AlreadyRagdolled == true then	
		ply:SetPos( ply.doll:GetPos() + Vector( 0, 0, 15 ) )
		ply.doll:Remove()
		ply:SetHealth(ply.tempH)
		ply:SetArmor(ply.tempA)
		timer.Create("PostSpawn", 0.1 , 1 , TimerPostSpawn, ply )
		ply:SetNoDraw( false ) 
		--ply:CreateShadow()
else	
ply.AlreadyRagdolled = false
ply:SetNoDraw( false ) 
--ply:CreateShadow()

// EQUIPMENT RESET //
ply.FirstAidSpray = 2
ply.ShieldModule = 0
ply.clipvest = false
ply.GasMask = false
ply.lasbox = nil
/////////////////////


// SPAWN LOCATION //
if droplocation then
local xx = math.Rand(-1,1)
local yy = math.Rand(-1,1)

ply:SetPos(droplocation + Vector(100*xx,100*yy,50))
end
///////////////////


if DoctorColossus and DoctorColossus.Follow == ply then -- stop kleiner!
DoctorColossus.Follow = nil
end

ply.wepsharing = false

ply.tempH = 100
ply.LastHitTime = CurTime()
ply.ShieldTime = 0
ply:ConCommand("-duck")
timer.Create("PostSpawn", 0.1 , 1 , TimerPostSpawn, ply ) -- I'll make the functions
ply.SlowBleedOut = false
ply.BleedTime = CurTime()
end
ply:SetNWEntity("raggy",NULL)
end
hook.Add("PlayerSpawn", "ResetValues", ResetValues)




function TimerPostSpawn(ply)
		if ply:Alive() then
		LegDamage(ply, ply.hitgroups[HITGROUP_LEFTLEG] , ply.hitgroups[HITGROUP_RIGHTLEG] )
		ArmDamage(ply, ply.hitgroups[HITGROUP_LEFTARM] , ply.hitgroups[HITGROUP_RIGHTARM])
		headandbodydamage(ply, ply.hitgroups[HITGROUP_HEAD] , ply.hitgroups[HITGROUP_CHEST])
		SpraySend(ply, ply.FirstAidSpray)			
			ply:SetNWEntity("raggy",nil)	
				ply.curgunn = ply:GetActiveWeapon()
			/*	
				ply.MODEL = playermodels(ply)
		if ply:Team() == 1 then
		ply:SetModel("models/gman_high.mdl")		
		elseif ply:Team() == 2 then
		ply:SetModel(ply.MODEL)
		end
			*/
end
end


function playermodels(ply) -- THIS ISN'T WORKING !!!
local modnum = math.random(1,9)

if ply.TotalKills < 600 then
return tostring("models/Humans/Group01/Male_0"..modnum)
elseif ply.TotalKills < 2800 then
return tostring("models/Humans/Group02/Male_0"..modnum)
else
return tostring("models/Humans/Group03/Male_0"..modnum)
	end
		--models/odessa.mdl
		--models/Barney.mdl
		--models/Combine_Super_Soldier.mdl
end




function MYLIMBS( ply, limb, dmginfo ) 


if ply:Health() < 0 and ply.AlreadyRagdolled == false then ply:Kill() end

	

	
		if dmginfo:IsDamageType( DMG_BLAST ) then --to give explosions the "fuck that hurt" feeling
				if ply:Alive() then
				ply.hitgroups[HITGROUP_CHEST] = ply.hitgroups[HITGROUP_CHEST] - (dmginfo:GetBaseDamage()/3)
				local randy = FindAttackLocation(ply, dmginfo)
				if randy == 3 then
				
				ply.hitgroups[HITGROUP_RIGHTLEG] = ply.hitgroups[HITGROUP_RIGHTLEG] - (dmginfo:GetBaseDamage()/4)
				ply.hitgroups[HITGROUP_RIGHTARM] = ply.hitgroups[HITGROUP_RIGHTARM] - (dmginfo:GetBaseDamage()/4)
				
				elseif randy == 2 then
				ply.hitgroups[HITGROUP_RIGHTLEG] = ply.hitgroups[HITGROUP_RIGHTLEG] - (dmginfo:GetBaseDamage()/8)
				ply.hitgroups[HITGROUP_RIGHTARM] = ply.hitgroups[HITGROUP_RIGHTARM] - (dmginfo:GetBaseDamage()/8)
				ply.hitgroups[HITGROUP_LEFTLEG] = ply.hitgroups[HITGROUP_LEFTLEG] - (dmginfo:GetBaseDamage()/8)
				ply.hitgroups[HITGROUP_LEFTARM] = ply.hitgroups[HITGROUP_LEFTARM] - (dmginfo:GetBaseDamage()/8)
				elseif randy == 1 then
				ply.hitgroups[HITGROUP_LEFTLEG] = ply.hitgroups[HITGROUP_LEFTLEG] - (dmginfo:GetBaseDamage()/4)
				ply.hitgroups[HITGROUP_LEFTARM] = ply.hitgroups[HITGROUP_LEFTARM] - (dmginfo:GetBaseDamage()/4)
				
				end
				end
			end

		
		
	if (ply.hitgroups and ply.hitgroups[limb]) and ply:Armor() == 0 and ( !dmginfo:GetAttacker():IsPlayer() or dmginfo:GetAttacker() == ply ) then
		if limb == HITGROUP_STOMACH then
		ply.hitgroups[HITGROUP_CHEST] = ply.hitgroups[HITGROUP_CHEST] - (dmginfo:GetDamage()*2) --bundle chest with stomach
		else
		

		ply.tempH = ply:Health()

		ply.hitgroups[limb] = ply.hitgroups[limb] - (dmginfo:GetDamage()*2) 
		if ply.hitgroups[limb] <= 0 then
		ply:SetHealth(ply:Health() + ply.hitgroups[limb]) -- this means you take double damage from a red limb
		ply.hitgroups[limb] = 0
		ply.SlowBleedOut = true
		
		end
		end
	
	elseif ply:Armor() != 0 then
		ply:SetHealth(ply.tempH)
		
		if ply.LastHitTime and ply.LastHitTime > (CurTime()-3) and ( !dmginfo:GetAttacker():IsPlayer() or dmginfo:GetAttacker() == ply ) then --repetitive hits on armor causes it to deplete faster
			ply:SetArmor(ply:Armor() - dmginfo:GetDamage()*3)
		else
			ply:SetArmor(ply:Armor() - dmginfo:GetDamage())
		end
	
	elseif (ply.hitgroups and ply.hitgroups[limb]) and ply:Armor() == 0 and ( dmginfo:GetAttacker():IsPlayer() and dmginfo:GetAttacker() != ply ) then
		if limb == HITGROUP_STOMACH then
		ply.hitgroups[HITGROUP_CHEST] = ply.hitgroups[HITGROUP_CHEST] - dmginfo:GetDamage()/10 --bundle chest with stomach
		else
		ply.tempH = ply:Health()
		ply.hitgroups[limb] = ply.hitgroups[limb] - (dmginfo:GetDamage()/10) 
		if ply.hitgroups[limb] <= 0 then
		ply:SetHealth(ply:Health() + ply.hitgroups[limb])
		ply.hitgroups[limb] = 0
		ply.SlowBleedOut = true
		end
		end
	end
	
		LegDamage(ply,ply.hitgroups[HITGROUP_LEFTLEG], ply.hitgroups[HITGROUP_RIGHTLEG])
		headandbodydamage(ply, ply.hitgroups[HITGROUP_HEAD], ply.hitgroups[HITGROUP_CHEST])
		ArmDamage(ply, ply.hitgroups[HITGROUP_LEFTARM], ply.hitgroups[HITGROUP_RIGHTARM])
		
		
		if (ply.hitgroups[HITGROUP_LEFTARM]==0 or ply.hitgroups[HITGROUP_RIGHTARM]==0) and ply:GetActiveWeapon() != NULL and ply:GetActiveWeapon():GetHoldType() != "pistol" then
			local oneswap = true
				for k, wep in pairs(ply:GetWeapons()) do
					if wep:GetHoldType() == "pistol" and oneswap ==true then
					ply:SelectWeapon(wep:GetClass())
					end
				end
			end
			
ply.LastHitTime = CurTime()
		end
hook.Add("ScalePlayerDamage", "MYLIMBS", MYLIMBS )

function ScaleDamage( npc, hitgroup, dmginfo )
 if hitgroup == HITGROUP_HEAD and npc:GetClass() == "npc_fastzombie" then
	dmginfo:ScaleDamage( 1 )
 end
end
hook.Add("ScaleNPCDamage","ScaleDamage",ScaleDamage)

function ZombieCount(ply, inf, att, amt, dmginfo)

for k, play in pairs(player.GetAll()) do

if play.zombie == nil then
	if ply == play.doll and play.AlreadyRagdolled == true and play:Alive() and play:Armor() == 0 then
			if dmginfo:IsDamageType(DMG_CRUSH) or dmginfo:IsDamageType(DMG_FALL) then
			
			play.tempH = play.tempH - (dmginfo:GetDamage()/8)
			play:SetHealth( play:Health() - (dmginfo:GetDamage()/8))
			play.hitgroups[HITGROUP_RIGHTLEG] = play.hitgroups[HITGROUP_RIGHTLEG] - (dmginfo:GetDamage()/16) --this needs to be fixed to actually reflect the locations of damage
			play.hitgroups[HITGROUP_LEFTLEG] = play.hitgroups[HITGROUP_LEFTLEG] - (dmginfo:GetDamage()/16)
			elseif dmginfo:IsDamageType(DMG_DIRECT) or dmginfo:IsDamageType(DMG_BURN) then
			play.hitgroups[HITGROUP_CHEST] = play.hitgroups[HITGROUP_CHEST] - (dmginfo:GetDamage())
			play.tempH = play.tempH - dmginfo:GetDamage()
			play:SetHealth( play:Health() - dmginfo:GetDamage())
			else
			play.tempH = play.tempH - dmginfo:GetDamage()
			play:SetHealth( play:Health() - dmginfo:GetDamage())
			end

LegDamage(play, play.hitgroups[HITGROUP_LEFTLEG], play.hitgroups[HITGROUP_RIGHTLEG])
			if play.tempH <= 0 and play:Alive() then
			play:KillSilent() 
			timer.Create(string.format("RagTimer:%s",play:Nick()), 15, 1, removedoll, play, play.doll )
			RagdollDeath(play)
			end
	end
end
end

if ply:IsNPC() and ply:GetClass() != "npc_antlionguard" and ply:GetClass() != "npc_hunter"  then
dmginfo:ScaleDamage(1)
if ply:Health() > 5 and ply.lastattacker != att and att:IsPlayer() then ply.lastattacker = att end --- for the assist system

elseif ply:IsNPC() and (ply:GetClass() == "npc_antlionguard" or ply:GetClass() == "npc_hunter") then
dmginfo:ScaleDamage((2/team.NumPlayers(2))+0.5)
if ply:Health() > 5 and ply.lastattacker != att and att:IsPlayer() then ply.lastattacker = att end

end

if ply:GetClass() == "npc_kleiner" and att:IsPlayer() then
dmginfo:ScaleDamage(0)
end

if ply:IsPlayer() and att:IsPlayer() and dmginfo:GetDamageType() != DMG_NERVEGAS and ply != att and inf:GetClass() != "gas_canister" then
dmginfo:ScaleDamage(0.1)
AltDown(att, att.Altruism ,20)


elseif ply:GetClass() == "npc_citizen" and att:IsPlayer() and !ply.isstopped then
ply:SetTarget(att)
	ply:SetLastPosition(ply:GetPos())
		ply:SetSchedule(SCHED_FORCED_GO_RUN)
	ply.isstopped = true
timer.Simple(20,function()
if ply:IsValid() then
ply.isstopped = false
	ply:SetLastPosition(Destination)
	ply:SetSchedule(SCHED_FORCED_GO_RUN)
end
end)

end


if ply:IsPlayer() then
	ply.ShieldTime = CurTime() + 10

	local a = dmginfo:GetDamageForce()
	local mag = math.sqrt((a.x * a.x) + (a.y * a.y) + (a.z *a.z))
	if (mag > 10000 or ply:IsOnFire()) and ply:Alive() and ply.AlreadyRagdolled == false and ply:Armor() == 0 and !att:IsPlayer() then --antlion guards and explosives can achieve over 10000 easily
				
			savestuff(ply)
			ragdollplayer(ply)
			
					local chest =ply.doll:GetPhysicsObjectNum(1)
					chest:ApplyForceCenter(dmginfo:GetDamageForce())
					
			
				ply.tempH = ply:Health() - dmginfo:GetDamage() 
				ply.tempA = ply:Armor()
			ply.waittimer = CurTime() + ( 10 - (ply.hitgroups[HITGROUP_CHEST]/10)) --if your chest is hurting, getting up is more difficult
			if ply:IsOnFire() then
			ply:Extinguish()
			ply.doll:Ignite(10,0)
			end
	end
	
	
	if ( dmginfo:IsDamageType(DMG_DISSOLVE)  ) and !att:IsPlayer() then --or dmginfo:IsDamageType(DMG_BULLET)
		if att:GetClass() == "npc_hunter" then
		dmginfo:ScaleDamage(0.5)
		else
		dmginfo:ScaleDamage(2)
		end
	MYLIMBS(ply, ProjectileHitLocation(ply,dmginfo) ,dmginfo)
	
	end
	
	
local randlimb = HITGROUP_CHEST
if ( dmginfo:IsDamageType (DMG_SLASH) or dmginfo:IsDamageType( DMG_CLUB ) ) and ply.AlreadyRagdolled == false then
	if att:GetClass() == "npc_antlionguard" then	
		randlimb = HITGROUP_CHEST 
		--dmginfo:ScaleDamage(1)
	elseif (att:GetClass() == "npc_headcrab" or att:GetClass() == "npc_headcrab_fast" or att:GetClass() == "npc_headcrab_black") then
		randlimb = HITGROUP_HEAD
		if ply.GasMask then
		dmginfo:ScaleDamage(0.1)
		else
		dmginfo:ScaleDamage(0.4)
		end
				if ply.hitgroups[HITGROUP_HEAD] == 0 then
					if att:GetClass() == "npc_headcrab" then
						HeadHumped(ply, att, "npc_zombie")
					elseif att:GetClass() == "npc_headcrab_fast" then
						HeadHumped(ply, att, "npc_fastzombie")
					elseif att:GetClass() == "npc_headcrab_black" then
						HeadHumped(ply, att, "npc_poisonzombie")
					end
				end
				
	elseif att:GetClass() == "npc_antlion" or att:GetClass() == "npc_zombie_torso" or att:GetClass() == "npc_antlion_worker" then
		if ply:Alive() then
		dmginfo:ScaleDamage(0.8)
			local randy = FindAttackLocation(ply, dmginfo)
				if randy == 3 then
				randlimb = HITGROUP_RIGHTLEG
				elseif randy == 2 then
				randlimb = HITGROUP_CHEST --well technically pelvis or the top of a leg but I stand by this code
				elseif randy == 1 then
				randlimb = HITGROUP_LEFTLEG
				end
			end
	else
	if ply:Alive() then
	dmginfo:ScaleDamage(0.8)
		local randy = FindAttackLocation(ply, dmginfo)
		if randy == 3 then
			randlimb = HITGROUP_RIGHTARM
		elseif randy == 2 then
			randlimb = HITGROUP_CHEST
		elseif randy == 1 then
			randlimb = HITGROUP_LEFTARM
		end
	end
	end
	MYLIMBS(ply, randlimb ,dmginfo)
	end
	
	if !dmginfo:IsDamageType(DMG_SLASH) and att:GetClass() == "npc_antlion_worker" then
	ply.hitgroups[HITGROUP_RIGHTLEG] = ply.hitgroups[HITGROUP_RIGHTLEG] - 1
	ply.hitgroups[HITGROUP_LEFTLEG] = ply.hitgroups[HITGROUP_LEFTLEG] - 1
	ply.hitgroups[HITGROUP_CHEST] = ply.hitgroups[HITGROUP_CHEST] - 1
	LegDamage(ply, ply.hitgroups[HITGROUP_LEFTLEG],  ply.hitgroups[HITGROUP_RIGHTLEG])
	headandbodydamage(ply, ply.hitgroups[HITGROUP_HEAD], ply.hitgroups[HITGROUP_CHEST])
	end
	
	if ply:Armor() != 0 then
			local dir = ply:GetPos() - att:GetPos()
			local effectdata = EffectData()
            effectdata:SetOrigin( ply:GetPos() + Vector(0,0,35) + dir:GetNormalized() * -2 )
            effectdata:SetNormal( dir:GetNormalized() * -3 )
            effectdata:SetMagnitude( 2 )
            effectdata:SetScale( 3 )
            effectdata:SetRadius( 6 )
        util.Effect( "Sparks", effectdata )
	end
	
end
end
hook.Add("EntityTakeDamage", "ZombieCount", ZombieCount) 

function teammatefail(ply,att,dmginfo)
if OVERRIDE and OVERRIDE == ply then
	for k,teammate in pairs(player.GetAll()) do
		if OVERRIDE != teammate then
			AltDown(teammate,teammate.Altruism,15)
		end
	end
	OVERRIDE = nil
end

if att:IsPlayer() and ply != att and dmginfo:GetDamageType() != DMG_NERVEGAS then
	AltDown( att, att.Altruism,5)
end	
end
hook.Add("DoPlayerDeath", "teammatefail", teammatefail) 

function LegBreaker( ply, speed )
if ply:Armor() > 0 then
	ply:SetArmor(ply:Armor()-(speed/40))
	ply.LastHitTime = CurTime()
	ply.ShieldTime = CurTime() + 10
	ply:SetHealth(ply.tempH)
else
	ply.hitgroups[HITGROUP_LEFTLEG] = ply.hitgroups[HITGROUP_LEFTLEG] - (speed/40)
	ply.hitgroups[HITGROUP_RIGHTLEG] = ply.hitgroups[HITGROUP_RIGHTLEG] - (speed/40)
	if ply.hitgroups[HITGROUP_LEFTLEG] < 0 then ply.hitgroups[HITGROUP_LEFTLEG] = 0 end
	if ply.hitgroups[HITGROUP_RIGHTLEG] < 0 then ply.hitgroups[HITGROUP_RIGHTLEG] = 0 end
	LegDamage(ply, ply.hitgroups[HITGROUP_LEFTLEG],  ply.hitgroups[HITGROUP_RIGHTLEG])
	savestuff(ply)
			ply.tempH = ply:Health() - speed/40
			ply.tempA = ply:Armor()
	ragdollplayer(ply)
	
		local chest =ply.doll:GetPhysicsObjectNum(1)
		chest:ApplyForceCenter(Vector(0,0,-speed))
	
	
	ply.waittimer = CurTime() + ( 10 - (ply.hitgroups[HITGROUP_CHEST]/10))
end
end
hook.Add("GetFallDamage","LegBreaker",LegBreaker)

///////////////////////////////////
///-----Think Section-----------///
///////////////////////////////////

function GetUpThink()
for k, ply in pairs (player.GetAll()) do

	if ply:Armor() < (ply.ShieldModule * 50) and ply.ShieldTime and ply.ShieldTime < CurTime() and ply.ShieldModule != 0 then
	ply:SetArmor(ply:Armor() + 1)
	ply.ShieldTime = CurTime() + ( (1/(math.exp( (CurTime()-ply.LastHitTime)/200*ply.ShieldModule )-0.9)) ) -- excessively complex, the way I like it
	end


	if  ply.AlreadyRagdolled == true and ply:Alive() and ply.doll != nil and ply.zombie == nil then
	local dollspeed = math.sqrt((ply.doll:GetVelocity().z*ply.doll:GetVelocity().z)+(ply.doll:GetVelocity().x*ply.doll:GetVelocity().x)+(ply.doll:GetVelocity().y*ply.doll:GetVelocity().y))
		if ply.waittimer and ply.waittimer < CurTime() and dollspeed < 5 and dollspeed > -5  then
					ply:SetNoTarget( false )
					ply:SetParent()
					ply:Spawn()
					ply:EmitSound("vo/npc/male01/moan04.wav")

		end
	end
	
	--------------------------------- You now have a 3 sec pause upon receiving damage
	if ply:KeyDown( IN_SPEED ) then
	
		if ply.LastHitTime and ply.LastHitTime < (CurTime() - 3) then
			if ply:GetRunSpeed() == ply:GetWalkSpeed() then
				LegDamage(ply,ply.hitgroups[HITGROUP_LEFTLEG], ply.hitgroups[HITGROUP_RIGHTLEG])
			end
		else
			ply:SetRunSpeed(ply:GetWalkSpeed())
		end
	
	end
	---------------------------------
	
	
	--------------------------------- DIVING! players can now do a painful dive to escape danger. very risky!
	
	if ply:KeyDown(IN_SPEED) and ply:KeyDown(IN_JUMP) and (!ply.NextDive or ply.NextDive < CurTime()) and ply.AlreadyRagdolled == false and ply:Team() != 1 and ply.hitgroups[HITGROUP_LEFTLEG] > 0 and ply.hitgroups[HITGROUP_RIGHTLEG] > 0 then
	ply.NextDive = CurTime() + 5
	
	local velocity = ( ply:GetVelocity():Normalize() + Vector(0,0,0.25) )*4000
	savestuff(ply)
	ragdollplayer(ply)
		
		if ply:KeyDown(IN_FORWARD) then -- need those arms out for epicness
					
				local rhand = ply.doll:GetPhysicsObjectNum(7)
				rhand:ApplyForceCenter(velocity*1)
				
				local lhand = ply.doll:GetPhysicsObjectNum(5)
				lhand:ApplyForceCenter(velocity*1)
				
		timer.Create("ArmThrow"..ply:Nick(),0.1,5,function()
			if ply.AlreadyRagdolled then
				local rhand = ply.doll:GetPhysicsObjectNum(7)
				rhand:ApplyForceCenter(velocity*0.1)
				
				local lhand = ply.doll:GetPhysicsObjectNum(5)
				lhand:ApplyForceCenter(velocity*0.1)
			end
		end)
		
		end
		local chest = ply.doll:GetPhysicsObjectNum(1)
		chest:ApplyForceCenter(velocity*3)
		
		local lfore = ply.doll:GetPhysicsObjectNum(4)
		lfore:ApplyForceCenter(velocity*0)
		
		local rfore = ply.doll:GetPhysicsObjectNum(6)
		rfore:ApplyForceCenter(velocity*0)
		
		if ply:KeyDown(IN_BACK) then -- this should make you do a little backflip
		--local luppa = ply.doll:GetPhysicsObjectNum(3)
		--luppa:ApplyForceCenter(velocity*1.5)
		
		--local ruppa = ply.doll:GetPhysicsObjectNum(2)
		--ruppa:ApplyForceCenter(velocity*1.5)
	
		local lfoot = ply.doll:GetPhysicsObjectNum(13)
		lfoot:ApplyForceCenter(velocity*-0.3)
	
		local rfoot = ply.doll:GetPhysicsObjectNum(14)
		rfoot:ApplyForceCenter(velocity*-0.3)
		
		local lcalf = ply.doll:GetPhysicsObjectNum(12)
		lcalf:ApplyForceCenter(velocity*-0.3)
		
		local head = ply.doll:GetPhysicsObjectNum(10)
		head:ApplyForceCenter(velocity*1)
		
		local rcalf = ply.doll:GetPhysicsObjectNum(9)
		rcalf:ApplyForceCenter(velocity*-0.3)
		end
		
		ply.tempH = ply:Health()
		ply.tempA = ply:Armor()
		ply.waittimer = CurTime() + ( 5 - (ply.hitgroups[HITGROUP_CHEST]/5)) --if your chest is hurting, getting up is more difficult
	
	end
	
	
	---------------------------------- Ew it took me an entire afternoon to get the diving... OK? All I need is for the arms not to spaz out and I'll be happy
	
	---------------------------------- The easy way to make the waypoint follow the ragdoll/ make npc's attack it
	
	if ply.AlreadyRagdolled and ply.doll then
	ply:SetPos(ply.doll:GetPos() + Vector(0,0,40))
	end
	
	----------------------------------
	
	

	if ply.BleedTime and ply.BleedTime < CurTime() and ply.SlowBleedOut == true and ply.zombie == nil and ply.AlreadyRagdolled == false then
	ply:SetHealth(ply:Health() - 5 )
	for group=1,7 do
	if group != 3 and ply.hitgroups[group] > 0 then
	ply.hitgroups[group] = ply.hitgroups[group] -math.ceil(0.05*maxlimb[group]) -- So that you can see yourself deteriorating
		
	end
	end
	LegDamage(ply,ply.hitgroups[HITGROUP_LEFTLEG], ply.hitgroups[HITGROUP_RIGHTLEG])
	headandbodydamage(ply, ply.hitgroups[HITGROUP_HEAD], ply.hitgroups[HITGROUP_CHEST])
	ArmDamage(ply, ply.hitgroups[HITGROUP_LEFTARM], ply.hitgroups[HITGROUP_RIGHTARM])
	ply.BleedTime = CurTime() + math.random(5,10)
		if ply:Health() <= 0 then
			if ply:Alive() then
				ply:Kill()
			end
		ply.SlowBleedOut = false
		end
	end
	
	if ply.BleedTime and ply.BleedTime < CurTime() and ply.zombie != nil then
		ply.zombie:Spawn()

		ply:Spectate( OBS_MODE_CHASE )
		ply:SpectateEntity( ply.zombie )
		ply:SetParent( ply.zombie )
		
				
		ply.zombie = nil
		ply.AlreadyRagdolled = false
		if ply.doll:IsValid() then
			ply.doll:Remove()
		end
			timer.Create(string.format("zombeh%s",ply:Nick()),5,1, function()
			ply:SetNoTarget( false )
			ply:SetParent()
			ply:KillSilent()
			ply:Spawn()
		end)
	end
	
	if ply.curgunn != nil and ply:GetActiveWeapon() != NULL then
	if ply:GetActiveWeapon():GetClass() != ply.curgunn then 
	
			if (ply.hitgroups[HITGROUP_LEFTARM]==0 or ply.hitgroups[HITGROUP_RIGHTARM]==0) and ply:GetActiveWeapon():GetHoldType() != "pistol" then
				ply:SelectWeapon(ply.curgunn)
			end
	ply.curgunn = ply:GetActiveWeapon():GetClass()
	ClipSize(ply,ply:GetActiveWeapon())
	end
	end
	
	
	if ply.lasbox then
			local entty = ents.Create("crosshairs")
		entty:SetPos( ply:GetPos())
		entty.attachedplayer = ply
		entty:Spawn()
		entty:Activate()
		constraint.Weld(ply,entty,10,0,0,true)
		ply.lasbox = false
	end
	end
end
hook.Add("Think", "GetUpThink" , GetUpThink)



function FirstAid(ply, key )

if key == IN_USE then

local pos = ply:GetShootPos()
local ang = ply:GetAimVector()
local tracedata = {}
tracedata.start = pos
tracedata.endpos = pos+(ang*100)
tracedata.filter = ply
local trace = util.TraceLine(tracedata)

///////////////////////////////////
///		Medical Aid Section!    ///
///////////////////////////////////
-- NOW AUTOMATICALLY SELECTS THE MOST DAMAGED LIMB- MAKES HEALING FASTER AND LESS CLUMSY

	if trace.Hit and trace.Entity:IsPlayer() and ply.FirstAidSpray > 0 then
			ply:ChatPrint(string.format( "You healed %s", trace.Entity:Nick() ))
			local mysound = CreateSound(ply, Thruster_Sound ) -- That lovely thruster sound :P
			mysound:Play()
			timer.Create(string.format( "Spraysound:%s", ply ),2 , 1, function()
			mysound:Stop()
			end)
			
	ply.FirstAidSpray = ply.FirstAidSpray - 1
	SpraySend(ply, ply.FirstAidSpray)

		
--local limb = trace.HitGroup
local target = trace.Entity
local leastgroup = 1

		if target.FirstAidSpray == 0 and (target.hitgroups[HITGROUP_LEFTLEG] == 0 or target.hitgroups[HITGROUP_RIGHTLEG] == 0) then
			AltUp(ply, ply.Altruism ,3) -- You saved this guys life, nice job
		end
		
		
		for group = 1,7 do
		if 	target.hitgroups[group] and group != 3 then
			if target.hitgroups[group] < target.hitgroups[leastgroup] then
			leastgroup = group
			end
		target.hitgroups[group] = target.hitgroups[group]+math.Round(maxlimb[group]/5)
		if target.hitgroups[group] > maxlimb[group] then target.hitgroups[group] = maxlimb[group] end
		end
		end
		
		target.hitgroups[leastgroup] = target.hitgroups[leastgroup]+math.Round(3*maxlimb[leastgroup]/5)
		if target.hitgroups[leastgroup] > maxlimb[leastgroup] then target.hitgroups[leastgroup] = maxlimb[leastgroup] end
		
		
		
		trace.Entity.SlowBleedOut = false
		
LegDamage(target,target.hitgroups[HITGROUP_LEFTLEG], target.hitgroups[HITGROUP_RIGHTLEG])
headandbodydamage(target, target.hitgroups[HITGROUP_HEAD], target.hitgroups[HITGROUP_CHEST])
ArmDamage(target, target.hitgroups[HITGROUP_LEFTARM],target.hitgroups[HITGROUP_RIGHTARM])
		AltUp(ply, ply.Altruism ,7)
trace.Entity:SetHealth(trace.Entity:Health() + 40) 
if trace.Entity:Health() > trace.Entity:GetMaxHealth() then trace.Entity:SetHealth(trace.Entity:GetMaxHealth()) end

	///////////////////////////
	// Kleiner Follow & Wait //
	///////////////////////////
	
	elseif trace.Hit and trace.Entity:GetClass() == "npc_kleiner" and DoctorColossus then
		if DoctorColossus.Follow and DoctorColossus.Follow == ply then
		ply:ChatPrint("Kleiner will wait for you.")
		timer.Stop("DoctorColossus")
			DoctorColossus.Follow = nil
			DoctorColossus:SetLastPosition(DoctorColossus:GetPos())
			DoctorColossus:SetSchedule(SCHED_FORCED_GO_RUN)
		else
			DoctorColossus.Follow = ply
			ply:ChatPrint("Kleiner will follow you.")
			
			
			
		timer.Create("DoctorColossus",2,0,function()
		if DoctorColossus:IsValid() and DoctorColossus.Follow then
			local a = DoctorColossus:GetPos()
			local b = DoctorColossus.Follow:GetPos()
			local mag = math.sqrt( math.pow((a.x-b.x),2) + math.pow((a.y-b.y),2) + math.pow((a.z-b.z),2) )
			
			if mag < 1000 then
				DoctorColossus:SetLastPosition(DoctorColossus.Follow:GetPos())
				DoctorColossus:SetSchedule(SCHED_FORCED_GO_RUN)
			else
				DoctorColossus:SetLastPosition(DoctorColossus:GetPos())
				DoctorColossus:SetSchedule(SCHED_FORCED_GO_RUN)
				DoctorColossus.Follow:ChatPrint("You left Kleiner behind!")
				DoctorColossus.Follow = nil
			end
			
		elseif DoctorColossus:IsValid() and DoctorColossus.Follow == nil then
			DoctorColossus:SetLastPosition(DoctorColossus:GetPos())
			DoctorColossus:SetSchedule(SCHED_FORCED_GO_RUN)
		else
		
			timer.Stop("DoctorColossus")
			end
		end)
		
		
		
	end
	
	elseif trace.Hit and trace.Entity:GetClass() == "prop_ragdoll" then
		
		for k, johny in pairs(player.GetAll()) do
			if johny.doll == trace.Entity then
				if !johny:Alive() or !johny.AlreadyRagdolled then
					ply:EmitSound("vo/npc/male01/gordead_ques05.wav")
				else
					johny.waittimer = CurTime()
					AltUp(ply, ply.Altruism ,12)
				end
			end
		end
	
	
end
end
end
hook.Add( "KeyPress", "FirstAid", FirstAid )


function LegDamage(ply, Lleg, Rleg)
	if Lleg > 0 and Rleg > 0 then
		ply:SetWalkSpeed((Lleg+ Rleg)*1.6+20)
		ply:SetRunSpeed((5 *(Lleg+ Rleg)) +50)
		ply:ConCommand("-duck")
	else
		ply:ConCommand("+duck")
		ply:SetWalkSpeed(1)
		ply:SetRunSpeed(2)
	end
		
		umsg.Start("LeftLeg", ply)
		if Lleg > 0 then
		umsg.Short(Lleg)
		else
		umsg.Short(0)
		ply.SlowBleedOut = true
		end
		umsg.End()
		umsg.Start("RightLeg", ply)
		if Rleg > 0 then
		umsg.Short(Rleg)
		else
		umsg.Short(0)
		ply.SlowBleedOut = true
		end
		umsg.End()
end

function SpraySend(ply, cans)

		umsg.Start("SprayAmt", ply)
		umsg.Float(cans)
		umsg.End()


end




function ArmDamage(ply, Larm, Rarm)
		
		umsg.Start("LeftArm", ply)
		if Larm > 0 then
		umsg.Short(Larm)
		else
		umsg.Short(0)
		end
		umsg.End()

		umsg.Start("RightArm", ply)
		if Rarm > 0 then
		umsg.Short(Rarm)
		else
		umsg.Short(0)
		end
		umsg.End()
		
end

function headandbodydamage(ply, head, body)
		umsg.Start("Head", ply)
		if head > 0 then
		umsg.Short(head)
		else
		umsg.Short(0)
		end
		umsg.End()
		umsg.Start("Body", ply)
		if body > 0 then
		umsg.Short(body)
		else
		umsg.Short(0)
		end
		umsg.End()
end




function removedoll(ply,  doll)
if doll:IsValid() then
doll:Remove()
doll = nil
end
if !ply:Alive() then
ply:Spawn()
end
end



function RagdollDeath( ply )
if ply.AlreadyRagdolled == true then
	ply:EmitSound("vo/npc/male01/pain08.wav")
	ply:SetNoTarget( false )
	ply:SetParent()
	ply.AlreadyRagdolled = false
	end
end
hook.Add("PlayerDeath","RagdollDeath",RagdollDeath)


function HeadHumped(ply, att, zombietype)
				ply:StripWeapons()
				ragdollplayer(ply)
				ply.zombie = ents.Create(zombietype)
				ply.zombie:SetPos(ply.doll:GetPos()) 
				att:Remove()
				if SHAID then
				npctotalnum = npctotalnum - 1 
				end
				ply.BleedTime = CurTime() + 5
end

////////////////////////////////////
///	   Clip Size Function    	 ///
////////////////////////////////////

function ClipSize(ply, wep)
		local curmax = -1
		if wep.Primary != nil then
		curmax = wep.Primary.ClipSize
		end
		umsg.Start("clipsize", ply)
		umsg.Float(curmax)
		umsg.End()
end
////////////////////////////////////
///		 Ragdoll Function        ///
////////////////////////////////////

function ragdollplayer(ply)
					local ragdoll = ents.Create( "prop_ragdoll" ) --Special thanks to overv for this section... the wiki wasn't very useful
					ragdoll:SetModel( ply:GetModel() )
					ragdoll:SetPos( ply:GetPos() )
					ragdoll:SetAngles( ply:GetAngles() )
					ragdoll:Spawn()
					ragdoll:Activate()
					
						for q=1,128 do -- Special thanks to Dvondrake for this small chunk, I don't really understand how to do much with ragdolls.
							local bone = ragdoll:GetPhysicsObjectNum( q )  
          
								if ValidEntity( bone ) then  
									local bonepos, boneang = ply:GetBonePosition( ragdoll:TranslatePhysBoneToBone( q ) )  
      
									bone:SetPos( bonepos )  
									bone:SetAngle( boneang )   
								end 
						end
					
					
					
					if ply:GetInfoNum("sh_fpdeath") == 0 then
						ply:Spectate( OBS_MODE_CHASE )
						ply:SpectateEntity( ragdoll )
						ply:SetParent( ragdoll )
					end

					ply.AlreadyRagdolled = true
					
					if ply.doll != nil and ply.doll:IsValid() then
					ply.doll:Remove()
					end
					
					ply.doll = ragdoll
					ply:SetNWEntity("raggy",ply.doll)
					ply:SetNoDraw( true ) 
end

////////////////////////////////////
///	   Self Heal Function        ///
////////////////////////////////////
function Self_Heal(ply, c ,argument)
local arg = tonumber(argument[1])
	if ply.FirstAidSpray > 0 then
	ply.FirstAidSpray = ply.FirstAidSpray - 1
	ply.hitgroups[arg] = ply.hitgroups[arg] + (maxlimb[arg]*3)/5
	AltDown(ply, ply.Altruism ,35)
	ply:SetHealth(ply:Health() + 20)
	if ply:Health() > 100 then ply:SetHealth(100) end
	
	if ply.hitgroups[arg] > maxlimb[arg] then ply.hitgroups[arg] = maxlimb[arg] end
	
	local mysound = CreateSound(ply, Thruster_Sound ) -- That lovely thruster sound :P
			mysound:Play()
			timer.Create(string.format( "Spraysound:%s", ply ),2 , 1, function()
				mysound:Stop()
			end)
	end
		local stillbleed = false
		for group = 1,7 do
			if group != 3 and ply.hitgroups[group] == 0 then
			stillbleed = true
			end
		end
	ply.SlowBleedOut = stillbleed
		
		LegDamage(ply,ply.hitgroups[HITGROUP_LEFTLEG], ply.hitgroups[HITGROUP_RIGHTLEG])
		headandbodydamage(ply, ply.hitgroups[HITGROUP_HEAD], ply.hitgroups[HITGROUP_CHEST])
		ArmDamage(ply, ply.hitgroups[HITGROUP_LEFTARM], ply.hitgroups[HITGROUP_RIGHTARM])
		SpraySend(ply, ply.FirstAidSpray)	
end
concommand.Add("Self_Heal", Self_Heal)

function savestuff(ply)
ply.gunn = {}
				ply.SAmmo = {}
				ply.AmmoName = {}
				
				
				if ply:GetActiveWeapon() != NULL then
				ply.curgunn = ply:GetActiveWeapon():GetClass()
				end
				
				
					for k, wep in pairs (ply:GetWeapons()) do
						
						ply.gunn[k] = {}
						
						// Save Guns & Upgrades //
						ply.gunn[k].Class = wep:GetClass()
						ply.gunn[k].CurrentClip = wep:Clip1()
						ply.gunn[k].upgrade1 = wep:GetDTBool(1)
						ply.gunn[k].upgrade2 = wep:GetDTBool(2)
						ply.gunn[k].upgrade3 = wep:GetDTBool(3)
						
						//Save Primary Ammo //
						if (wep:GetPrimaryAmmoType() == nil or ply:GetAmmoCount(wep:GetPrimaryAmmoType()) == nil ) then 
						ply.SAmmo[2*k] = 0
						ply.AmmoName[2*k] = "GaussEnergy"
						else
						
						ply.SAmmo[2*k] = ply:GetAmmoCount(wep:GetPrimaryAmmoType())
						ply.AmmoName[2*k] = wep:GetPrimaryAmmoType() 
						end
						
						// Save Secondary Ammo //
						if (wep:GetSecondaryAmmoType() == nil or ply:GetAmmoCount(wep:GetSecondaryAmmoType()) == nil ) then
						ply.SAmmo[(2*k)+1] = 0
						ply.AmmoName[(2*k)+1] = "GaussEnergy"
						else
						ply.SAmmo[(2*k)+1] = ply:GetAmmoCount(wep:GetSecondaryAmmoType())
						ply.AmmoName[(2*k)+1] = wep:GetSecondaryAmmoType()
						end
						
						
					end
			ply:StripWeapons()
			ply:RemoveAllAmmo()
			ply.AlreadyRagdolled = true
end

///////////////////////////////////////////		I should give this to the good people of facepunch!
///		Super Critical Fucntion			///
///////////////////////////////////////////
function FindAttackLocation(ply, dmginfo) -- I still can't believe I could put my math skills to use

local pi = 3.141592654													--	a
local a = ply:GetAimVector()											--	\	This angle between is found through the equation:
local b = (dmginfo:GetDamageForce()):GetNormalized() 					--	 \	
local theta = math.acos(Vector(a.x,a.y):DotProduct(Vector(b.x,b.y)))	--	  \_______b		arccos(a . b)
local sign = Vector(a.x,a.y):Cross(Vector(b.x,b.y))						--    
if sign.z < 0 and theta > (pi / 6) and theta < (5*pi / 6) then 			-- then the side in which the angle is on is found by the cross product
return 1 -- LEFT SIDE													-- of the x and y components (which produces positive number in the z direction
elseif sign.z > 0 and theta > (pi / 6) and theta < (5*pi / 6) then		-- for anti-clockwise and negative z for clockwise. This is then used to
return 3 -- RIGHT SIDE													-- determine which side the angle is on and therefore where the attack came
else																	-- from. This can be applied to more than just attacks, as long as you have
return 2 -- CENTRE														-- two normalised vectors :D
end
end

function getchestPosAng(ent)
    local attachmentID=ent:LookupAttachment("chest")
    return ent:GetAttachment(attachmentID)
end

function ProjectileHitLocation(ply,dmginfo)
local pi = 3.141592654						

local c = dmginfo:GetDamagePosition() - getchestPosAng(ply).Pos
local a = ply:GetForward()

if c.z > 6 and c.z < 8 then
	return HITGROUP_HEAD

elseif c.z < -5 then

local b = c:Normalize()
local sign = Vector(a.x,a.y):Cross(Vector(b.x,b.y))	

	if sign.z > 0 then
		return HITGROUP_LEFTLEG
	elseif sign.z < 0 then
		return HITGROUP_RIGHTLEG				
	end										
	
elseif c.z < 6 and c.z > 0	then
local b = c:Normalize()
local sign = Vector(a.x,a.y):Cross(Vector(b.x,b.y))	
local theta = math.acos(Vector(a.x,a.y):DotProduct(Vector(b.x,b.y)))	
					    
	if sign.z > 0 and theta < (pi / 2) then 			
		return HITGROUP_LEFTARM												
	elseif sign.z < 0 and theta < (pi / 2) then		
		return HITGROUP_RIGHTARM												
	else																	
		return HITGROUP_CHEST												
	end
	
else

return HITGROUP_CHEST	

	
end


end










	
/*
This is SHAID, the Survival Horror Artificial Intelligence Director
made by Wunce 

Yes, I learnt how to make timers whilst making this and I must say they are pretty cool

This is going to be released first I think, as many people would prefer something togleable over the more permanent limb_health
*/



 CreateConVar( "SHAID_Zombies_Only",  0, { FCVAR_REPLICATED, FCVAR_ARCHIVE }) -- These are working now :D
 CreateConVar( "SHAID_Antlions_Only", 0, { FCVAR_REPLICATED, FCVAR_ARCHIVE })
 CreateConVar( "SHAID_NPC_volume", 5, { FCVAR_REPLICATED, FCVAR_ARCHIVE })
 CreateConVar( "SHAID_Ep2_critters",  0, { FCVAR_REPLICATED, FCVAR_ARCHIVE })

Spawn = {}
NPCenemies = {}
totalenemies = 0
i = 0
count = 0
slaughter = 0
enpersec = 0
zombieamt = 11
antlionamt = 9
remainder = 0
npctotalnum = 0
desiredslaughter = 1
enemyhp = 1

contentss = {} 
ObjPoint= {}
ObjNum = 0



timer.Create("Director", 10 , 0 , function()
if SHAID == true then
slaughter = (4 * slaughter) / 5 --slaughter is constantly decreasing so previous kills weigh less than recent ones
count = 0
local totalhealth = 0
local totalleg = 0		-- ammo should probably be here also
local totalarm = 0
local totalhead = 0
enpersec = 0

// Data Collection //
for k, ply in pairs (player.GetAll()) do
if ply.optin == true then --so that players who don't want to kill zombies aren't chased
count = count + 1
ply.npctargetnum = count -- this could probably be replaced with "k"
totalhealth = ply:Health() + totalhealth

if ply.hitgroups[HITGROUP_LEFTLEG] != nil then
totalleg = totalleg + ply.hitgroups[HITGROUP_LEFTLEG] + ply.hitgroups[HITGROUP_RIGHTLEG] 
totalarm = totalarm + ply.hitgroups[HITGROUP_LEFTARM] + ply.hitgroups[HITGROUP_RIGHTARM]
totalhead = totalhead + ply.hitgroups[HITGROUP_HEAD]
end

slaughter = ply.killsection + slaughter
ply.killsection = 0
end
end

if count > 0 then
// Data Interpretation //
	if totalleg != nil then
		if totalleg/(count) > 40 then
		antlionamt = 1
		elseif totalleg/(count) < 15 then
		antlionamt = 9
		else
		antlionamt = 5
		end

		if totalarm/(count) > 40 then
		zombieamt = 19
		elseif totalarm/(count) < 15 then
		zombieamt = 11
		else
		zombieamt = 15
		end

		if totalhead/(count) < 5 then
		hcrab = false
		else
		hcrab = true
		end
	end

if totalhealth/(count) > 80 then 	
enpersec = 0.1
elseif totalhealth/(count) < 40 then
enpersec = -0.1
else 
enpersec = 0
end

/* FOR THE SLAUGHTER SECTION
its the sum to infinity of "x" (the number of kills each 10 sec, assume constant) and the ratio is (4/5)
this produces the equation 5x. In short that means that 5 multiplied by the kills per 10 sec is the slaughter figure,
so to work out the enemies to produce per sec, the desired slaughter is divided by 5 then 10 (50).
*/
local pi = 3.141592654	
-- IF YOU DO NOT UNDERSTAND THE GRAPH OF TRIGONOMETRIC FUNCTIONS DO NOT ALTER THE EQUATION BELOW

// current equation: lasts 10 min; variable peaks and troffs.
local constant = GetConVarNumber("SHAID_NPC_volume")
if constant < 5 then constant = 5 end
desiredslaughter = (constant)-(constant/2)*math.sin((pi* (CurTime() - BootTime))/150)+(2*constant/5)*math.sin((pi* (CurTime() - BootTime))/50) --surprised to see this works nicely.

if desiredslaughter < 0 then desiredslaughter = 0 end
if MassHorde then desiredslaughter = constant*2 end

if current_submode and DensityOverride then
	desiredslaughter = constant*DensityOverride
end

if  slaughter < (desiredslaughter - 4) then
enemyhp = 0.6 --slaughter now determines enemy health, not amount. in otherwords, if you can't cope with the # of enemies, they will spawn weaker
elseif slaughter < (desiredslaughter - 2) then
enemyhp = 0.8
elseif slaughter < (desiredslaughter + 2) then
enemyhp = 1.25
elseif  slaughter > (desiredslaughter + 4) then
enemyhp = 1.66 
else
enemyhp = 1

end
enpersec = desiredslaughter/50 + enpersec --this determines the output of enemies per second. usually will be a fraction.
end
else
enpersec = 0
end
end)


timer.Create("NPCnumchecker",60,0,function()
local strange = npctotalnum
npctotalnum = 0
	for k, NPC in pairs(NPCenemies) do 
		if NPC:IsValid() then
			npctotalnum = npctotalnum + 1
		end
	end
	if strange != npctotalnum then
		print("A discrepency has been detected. Fail safe has adjusted NPC counter to the correct value")
	end
end)


timer.Create("BossSpawn", 400 , 0 , function()
	if SHAID then
	local lolno = false
	
	for k, NPC in pairs(ents.FindByClass("npc_antlionguard")) do 
	lolno = true
	end
	
	if lolno == false then
	bossspawn = true
	end
	
	for k, NPC in pairs(ents.FindByClass("npc_*")) do -- Clean up npcs that have no target or aren't part of the system
		if (table.HasValue(NPCenemies,NPC) and !NPC.playertarget:IsValid() ) or (!table.HasValue(NPCenemies,NPC) and NPC:GetClass() != "npc_kleiner" and NPC:GetClass() != "npc_citizen") then
			NPC:TakeDamage(999)
		end
	end
	
	
	
	end
end)

timer.Create("SHAID_Spawn", 1 , 0 , function() --I made this so that it can only spawn 1 enemy at a time.
if SHAID == true and i != 0 and npctotalnum < (math.ceil(desiredslaughter)) and count > 0 then -- /\/\/\/\/ MAX NPCS ASSIGNED ON THIS LINE! /\/\/\/\/\/\/
remainder = remainder + enpersec
if remainder > 1 then
remainder = remainder -1


local EnemyType = DecideEnemyType() --this is where alot of crucial director stuff happens

NPCenemies[totalenemies] = ents.Create(EnemyType)

	if EnemyType == "npc_metropolice" then --this doesn't look as good as I first thought :O
		NPCenemies[totalenemies]:SetKeyValue("additionalequipment", "weapon_stunstick")
		NPCenemies[totalenemies]:SetMaxHealth(120) -- he's one crazy fucker
		NPCenemies[totalenemies]:SetHealth(120) -- he's one crazy fucker
	elseif EnemyType == "npc_antlionguard" then
		NPCenemies[totalenemies]:SetMaxHealth(1)
		NPCenemies[totalenemies]:SetHealth(1)
		print("antlion guard has spawned")
	else
	NPCenemies[totalenemies]:SetHealth(enemyhp * NPCenemies[totalenemies]:GetMaxHealth()) -- it isn't very noticable but its still there
	end


	local randply = 1
if count > 1 then
	randply = math.random(1, count-1) --this selects a random player to stalk.
end

if OVERRIDE then
	NPCenemies[totalenemies].playertarget = OVERRIDE
else
	for k,ply in pairs(player.GetAll()) do
		if randply == ply.npctargetnum then --FOR FUCKS SAKE THAT WAS THE PROBLEM ALL ALONG? OMG RARGH
			NPCenemies[totalenemies].playertarget = ply
		end
	end
end
local SpawnPoint = LocationSpawner(NPCenemies[totalenemies].playertarget)

NPCenemies[totalenemies]:SetPos(SpawnPoint) 
NPCenemies[totalenemies]:Spawn() 

StopTheViolence(NPCenemies[totalenemies]) -- Antlions and zombies now team up... against you
NPCenemies[totalenemies].stupidloop = 29


totalenemies = totalenemies + 1
npctotalnum = npctotalnum + 1
end
end
end)


timer.Create("SHAID_Chase", 1, 0, function() -- client keeps timing out. I wonder why. hasn't for a while. still don't know why

for k, NPC in pairs(NPCenemies) do

if NPC.playertarget != nil and NPC.playertarget:IsValid() then

if NPC.playertarget.optin and NPC:GetClass() != "npc_antlionguard" then
NPC:UpdateEnemyMemory(NPC.playertarget,NPC.playertarget:GetPos())
elseif NPC:GetClass() == "npc_antlionguard" then
	for k,ply in pairs(player.GetAll()) do
		if ply.optin then
		NPC:UpdateEnemyMemory(ply,ply:GetPos())
		end
	end
	
end

/* ALL OF THIS STUFF BELOW IS UNECCESSARY AND SHIT, I CAN'T BELIEVE THAT LITTLE FUNCTION ABOVE FIXES IT ALL!
local mag = math.sqrt((c.x * c.x) + (c.y * c.y) + (c.z * c.z))

if mag >= 1000 and NPC.stupidloop == 30 then
NPC:SetLastPosition(a) -- investigate this tomorrow. WITH A VENGANCE. <<<fixed>>>
NPC:SetSchedule(SCHED_FORCED_GO_RUN)
NPC.stupidloop = 0
elseif mag < 1000 then

			local tracedata = {}
			tracedata.start = b+Vector(0,0,50)
			tracedata.endpos = a+Vector(0,0,50)
			tracedata.mask = SOLID_BRUSHONLY
			local trace = util.TraceLine(tracedata)
			
			if trace.HitWorld and NPC.stupidloop > 25  then
			print(NPC:GetClass().." should now directly proceed to you")
			NPC:SetLastPosition(a) 
			NPC:SetSchedule(SCHED_FORCED_GO_RUN)
			NPC.stupidloop = 3
			
			elseif trace.HitWorld and NPC.stupidloop <= 25  then
			NPC.stupidloop = NPC.stupidloop + 1
			
			
			elseif !trace.HitWorld and NPC.stupidloop > 1  then
			--NPC:StopMoving() 
			NPC:SetLastPosition(b+(.1*(a-b))) --this makes them stop but not turn around, ie good enough
			NPC:SetSchedule(SCHED_FORCED_GO_RUN)
			NPC.stupidloop = 0
			elseif !trace.HitWorld and NPC.stupidloop <= 1 then
			--NPC:SetEnemy(NPC.playertarget)
			NPC.stupidloop = 0
			end



else
NPC.stupidloop = NPC.stupidloop + 1 --I'm sick of them constantly turning around for no reason
end
*/
elseif NPC.playertarget and !NPC.playertarget:IsValid() then

if count > 1 then
	randply = math.random(1, count-1) --this selects a random player to stalk.
end
	for k,ply in pairs(player.GetAll()) do
		if randply == ply.npctargetnum then 
			NPC.playertarget = ply
		end
	end


end

end

end)


function ObjectiveAdd(ply,com,arg)

if ply:IsAdmin() or ply:IsSuperAdmin() then
local tracedata = {}
tracedata.start = ply:GetShootPos()
tracedata.endpos = ply:GetShootPos() + ( ply:GetAimVector() * 50000 )
tracedata.filter = ply
local trace = util.TraceLine( tracedata )

	if trace.HitWorld then
	ObjNum = ObjNum + 1
	ObjPoint[ObjNum] = trace.HitPos + Vector(0,0,10)
	
	
	
	local map = string.gsub(game.GetMap(),"_","q")
	local Textfile = string.format("WunceFiles/%sobj.txt",map )
	local continental = {}
	if file.Exists(Textfile) then
	continental = glon.decode( file.Read( Textfile ) )
	table.insert(continental,ObjPoint[ObjNum])
	else
	continental[1] = ObjPoint[ObjNum]
	end
	
	file.Write( Textfile, glon.encode( continental ) )
	end
	
end

end

concommand.Add("SHAID_add_obj", ObjectiveAdd)



NextObjTime = 0
ChangeIntTime = 0
IntPoint = {}

timer.Create("SHAID_Objectives",5,0,function()
///////////////////
// NEW OBJECTIVE //
///////////////////
if ObjNum > 1 and droplocation then
			if CurObj == nil and NextObjTime < CurTime() and !current_submode then
			randynum = math.random(1,3)

				if randynum == 1 then -- perhaps this could be a seperate function?
				CurObj = "Demo"
				elseif randynum == 2 then
				CurObj = "Escort"
				elseif randynum == 3 then
				CurObj = "Thieves"
				end
				-- do voting later. for now, force the objective upon them
clienttext = " "
				if CurObj == "Escort" then
				
				ObjPos = ObjPoint[math.random(1,ObjNum)]
				DoctorColossus = ents.Create("npc_kleiner") 
				DoctorColossus:SetPos(ObjPos+Vector(30,0,0)) 
				DoctorColossus:SetMaxHealth(100)
				DoctorColossus:Spawn() 
				DoctorColossus:SetHealth(50)
				clienttext = "Escort Kliener to buy zone for extraction."
						umsg.Start("ObjMarker", nil)
						umsg.Vector(droplocation + Vector(0,0,100))
						umsg.End()
				
				elseif CurObj == "Demo" then
					ObjPos = ObjPoint[math.random(1,ObjNum)]
					ExplosiveCharge = ents.Create("demo_charge")
					ExplosiveCharge:SetPos(ObjPos+Vector(30,0,0))
						umsg.Start("ObjMarker", nil)
						umsg.Vector(ObjPos + Vector(0,0,100))
						umsg.End()
					ExplosiveCharge:Spawn()

					clienttext = "A crazy survivor planted a bomb. Defuse it."
						timer.Create("Demo",300,1,function()
							local explode = ents.Create("boom")

							explode:SetPos(ExplosiveCharge:GetPos())
							explode:SetVar("Owner",ExplosiveCharge)
							explode:SetVar("Scale",3)
							explode:SetAngles(ExplosiveCharge:GetAngles())
							explode:Spawn()
							ExplosiveCharge:Remove()
						umsg.Start("SlowMotion", nil) 
						umsg.Bool(true)
						umsg.End()
						game.ConsoleCommand("host_timescale 0.25\n")
							timer.Simple(3,function()
						umsg.Start("SlowMotion", nil) 
						umsg.Bool(false)
						umsg.End()
						game.ConsoleCommand("host_timescale 1\n")
							end)
						end)
						
						
				elseif CurObj == "Thieves" then
					ObjPos = ObjPoint[math.random(1,ObjNum)]
					local biggest = 0
					local letter = 0
					for q=1,ObjNum do
						local a = ObjPoint[q]-ObjPos 
						local mag = math.sqrt(a.x*a.x + a.y*a.y + a.z*a.z)
							if mag > biggest then
								biggest = mag
								letter = q
							end
					end
					
				Destination = ObjPoint[letter]				
						umsg.Start("ObjMarker", nil)
						umsg.Vector(Destination + Vector(0,0,100))
						umsg.End()
				Thief = {}
					for q=1,3 do 
						Thief[q] = ents.Create("npc_citizen")
						Thief[q]:SetPos(ObjPos+Vector(30,math.Rand(-1,1)*20,0))
						Thief[q]:SetKeyValue("additionalequipment", "weapon_smg1")
						Thief[q]:Spawn()
						Thief[q]:AddRelationship("player D_HT 99")
						--Thief[q].stupidloop
					end
					timer.Create( "ThiefEngage",3,1, function()
					for q=1,3 do
						Thief[q]:SetLastPosition(Destination) 
						Thief[q]:SetSchedule(SCHED_FORCED_GO_RUN)
						Thief[q]:SetCurrentWeaponProficiency( WEAPON_PROFICIENCY_PERFECT )
					end
						end)
					clienttext = "Thieves have stolen sensitive documents. Eliminate them."
				end
				
				
				
				
				for k, ply in pairs(player.GetAll()) do
					umsg.Start("NEWOBJ", ply)
					umsg.String(glon.encode(clienttext))
					umsg.End()
					if CurObj == "Demo" then	
						umsg.Start("Timer", ply) -- Probably could be sent with the one above.
						umsg.Float(CurTime() + 300)
						umsg.End()
					end
				--end	
				end
				
				clienttext = nil
				
			
			end

///////////////////
// OBJECTIVE END //
///////////////////

			if CurObj then
				
				if CurObj == "Escort" and !DoctorColossus:IsValid() then
				CurObj = nil
				clienttext = "Kleiner was killed."

							
				NextObjTime = CurTime() + 120
				
				elseif CurObj == "Demo" and !ExplosiveCharge:IsValid() then
				clienttext = "The bomb detonated."
				CurObj = nil
				OVERRIDE = nil
				NextObjTime = CurTime() + 120
				
				elseif CurObj == "Thieves" and !Thief[1]:IsValid() and !Thief[2]:IsValid() and !Thief[3]:IsValid() then
				for k,ply in pairs(player.GetAll()) do
						umsg.Start("OBJSUCCESS", ply) -- THIS IS TEMPORARY
						umsg.String(glon.encode( "Thieves killed. Sensitive documents destroyed." ))
						umsg.End()
						umsg.Start("ObjMarker", nil)
						umsg.Vector(Vector(0,0,0))
						umsg.End()
					ply.Cash = ply.Cash + 250
					sendmoney(ply, ply.Cash)
				ObjStrRte(ply, 1)
				
				end

							Destination = nil
							clienttext=nil
							CurObj = nil
				NextObjTime = CurTime() + 120
				

				
				--timer.Stop( "ThiefEngage")
				elseif CurObj == "Thieves" and (Thief[1]:IsValid() or Thief[2]:IsValid() or Thief[3]:IsValid()) then
				
					for k, ent in pairs(ents.FindInSphere( Destination, 200 )) do
						if table.HasValue(Thief,ent) then
						clienttext = "Thieves Escaped"
						if Thief[1]:IsValid() then Thief[1]:Remove() end
						if Thief[2]:IsValid() then Thief[2]:Remove() end
						if Thief[3]:IsValid() then Thief[3]:Remove() end
						NextObjTime = CurTime() + 120	
						CurObj = nil
						
						--timer.Stop( "ThiefEngage")
						end	
					end

				
				end
				
				if clienttext then
						for k, ply in pairs(player.GetAll()) do
							umsg.Start("OBJFAILURE", ply)
							umsg.String(glon.encode( clienttext ))
							umsg.End()
							umsg.Start("ObjMarker", nil)
							umsg.Vector(Vector(0,0,0))
							umsg.End()
							ObjStrRte(ply, 0)
						end
				clienttext = nil
				end
			end

if ChangeIntTime < CurTime() or current_submode then
	for q=1, ObjNum do
		if IntPoint[q] then
			if timer.IsTimer("inferno"..tostring(IntPoint[q])) then
				timer.Stop("inferno"..tostring(IntPoint[q]))
			elseif timer.IsTimer("turret"..tostring(IntPoint[q])) then
				timer.Stop("turret"..tostring(IntPoint[q]))
			end
			if IntPoint[q]:IsValid() then
				IntPoint[q]:Remove()
				if IntPoint[q].barrel then
					IntPoint[q].barrel:Remove()
				end
			end
		end
	end
end
if ChangeIntTime < CurTime() and !current_submode then
	for q=1, ObjNum do
		local randpoint = math.random(1,6)
		supastring = " "
		local offset = Vector(0,0,0)
			if ObjPos != ObjPoint[q] then
			
					if randpoint == 1  or randpoint == 2 then -- perhaps this could be a seperate function?
						supastring = "inferno_tower"
						offset = Vector(0,0,-10)
					elseif randpoint == 4 then
						supastring = "gas_canister"
					elseif randpoint == 3 or randpoint == 5 then
						supastring = "zombie_beacon"
					elseif randpoint == 6 then
					supastring = "turret_base"
					offset = Vector(0,0,15)
					end
				

					IntPoint[q] = ents.Create(supastring)
					IntPoint[q]:SetPos(ObjPoint[q]+offset)
					IntPoint[q]:Spawn()
			end
		end
		ChangeIntTime = CurTime() + 480
		end
		
		end
//////////////////////////////////
//	Fast HeadCrab Prevention!	//
//////////////////////////////////	
for k,crab in pairs(ents.FindByClass("npc_headcrab_fast")) do
if !table.HasValue(NPCenemies , crab) then
crab:TakeDamage(100)
end
end
	/*
	for k,guard in pairs(ents.FindByClass("npc_antlionguard")) do -- this will hopefully stop them from targeting a single player for ages
				for k, ent in pairs(ents.FindInSphere( guard:GetPos(), 2000 )) do
					if ent:IsPlayer() and guard.playertarget != ent then
						guard.playertarget = ent
					end
				end
			end
	*/		
end)


function LoadSpawns()
print("Loading Spawns")

local map = string.gsub(game.GetMap(),"_","q")
local Textfile = string.format("WunceFiles/%sspawns.txt",map )

if !file.Exists( Textfile ) then
print("SPAWN FILE FOR THIS MAP DOES NOT EXIST -> PLEASE ADD SPAWNS TO CREATE A FILE")

else
contentss = glon.decode( file.Read( Textfile ) )

			for q, lol in pairs(contentss) do
			Spawn[q] = contentss[q]
			i = q
			end
end
print("Loading Objectives")

local map = string.gsub(game.GetMap(),"_","q")
local Textfile = string.format("WunceFiles/%sobj.txt",map )

if !file.Exists( Textfile ) then
print("OBJ FILE FOR THIS MAP DOES NOT EXIST -> PLEASE ADD OBJECTIVE POINTS TO CREATE A FILE")

else
ObjPoint = glon.decode( file.Read( Textfile ) )

			for q, lol in pairs(ObjPoint) do
			ObjNum = q
			end
end
end
timer.Create("SHAID_LoadSpawns", 3 , 1 , LoadSpawns)


function ObjStrRte(ply, success)
ply.ObjStrikeRate = success + 0.9*ply.ObjStrikeRate
end


function SHAID_add_spawn(ply,command,argument) --this worked nicely and without a hitch
if ply:IsAdmin() or ply:IsSuperAdmin() then
local tracedata = {}
tracedata.start = ply:GetShootPos()
tracedata.endpos = ply:GetShootPos() + ( ply:GetAimVector() * 50000 )
tracedata.filter = ply
local trace = util.TraceLine( tracedata )

	if trace.HitWorld then
	i = i + 1
	Spawn[i] = trace.HitPos + Vector(0,0,10)
	
	
	
	local map = string.gsub(game.GetMap(),"_","q")
	local Textfile = string.format("WunceFiles/%sspawns.txt",map )
	
	if file.Exists(Textfile) then
	contentss = glon.decode( file.Read( Textfile ) )
	table.insert(contentss,Spawn[i])
	else
	contentss[1] = Spawn[i]
	end
	
	file.Write( Textfile, glon.encode( contentss ) )
	end
	
end
end
concommand.Add("SHAID_add_spawn",SHAID_add_spawn)

function removecurspawns()
	for q= 1, i do
		Spawn[q] = nil
	end
	i=0
end

function deletefile()
	local map = string.gsub(game.GetMap(),"_","q")
	local Textfile = string.format("WunceFiles/%sspawns.txt",map )
	if file.Exists( Textfile ) then
	file.Delete(Textfile)
	end
end

function SHAID_remove_all_spawns(ply, c, a ) -- I hope this works, its pretty untested
if ply:IsAdmin() or ply:IsSuperAdmin() then
	removecurspawns()
	deletefile()
end
end
concommand.Add("SHAID_remove_all_spawns",SHAID_remove_all_spawns)

function SHAID_Toggle(ply,command,argument)
if SHAID == true and (ply:IsAdmin() or ply:IsSuperAdmin()) then
SHAID = false
npctotalnum = 0
print("SHAID is now disabled")
timer.Destroy("Safety_Net")
elseif SHAID != true and (ply:IsAdmin() or ply:IsSuperAdmin()) then
SHAID = true
BootTime = CurTime()
timer.Create("Safety_Net", 1200 , 0 , function()
print("SAFETY NET RESET HAS BEEN RUN")
zombieamt = 19
antlionamt = 1
remainder = 0
npctotalnum = 0
desiredslaughter = 1
enemyhp = 1
end)
print("SHAID is now enabled")
end
end
concommand.Add("SHAID_Toggle",SHAID_Toggle)

function SHAID_Opt_in(ply,command,argument)
if ply.optin != true then
ply.optin = true
ply.killsection = 0
ply:ChatPrint("You have opted into SHAID")
else
ply.optin = false
ply:ChatPrint("You have opted out SHAID")
end
end
concommand.Add("SHAID_Opt_in",SHAID_Opt_in)


--hook.Add("PlayerDeath", "SHAID_disable", SHAID_disable)

function LocationSpawner(ply)
local possib = {}
local possibnum = 0
for k, spawner in pairs(Spawn) do
	local disty = 0
	if !nearobjective then
	disty = math.sqrt( math.pow((spawner.x - ply:GetPos().x),2) + math.pow((spawner.y - ply:GetPos().y),2) )
	else
	disty = math.sqrt( math.pow((spawner.x - nearobjective.x),2) + math.pow((spawner.y - nearobjective.y),2) )
	end
	if disty > 1500 and disty < 4000 then -- distances assigned here
		possibnum = possibnum + 1
		possib[possibnum] = spawner
	end
end

if possibnum == 0 then return Spawn[math.random(1,count)]
else return possib[math.random(1,possibnum)]

end
end

function DecideEnemyType()
local eptwo = GetConVarNumber("SHAID_Ep2_critters")
if GetConVarNumber("SHAID_Zombies_Only") == 1 then return "npc_fastzombie" --these may work now
elseif GetConVarNumber("SHAID_Antlions_Only") == 1 then return "npc_antlion"
else

local enemy = math.random(antlionamt,zombieamt) -- I should get dan's NPC pack so that more enemies can be added

if bossspawn == true then --when I get more boss npcs, add them here
	bossspawn = false
	if math.Rand(0,1) > 0.5 and eptwo == 1 then
		return "npc_hunter"
	else
		return "npc_antlionguard"
	end
	
else
	if enemy == 10 and eptwo == 1 then return "npc_antlion_worker" --replace this with something more appropriate
	elseif enemy < 10 and enemy != 4 and enemy !=5 then return "npc_antlion" 	-- READ THIS: YOU CAN CHANGE MY CODE BUT DON'T FUCKING UPLOAD IT
	elseif (enemy == 4 or enemy == 5) and hcrab then return "npc_headcrab_fast" -- REALLY, DON'T UPLOAD IT. GET SOME SKILL AND MAKE YOUR OWN WORK
	elseif enemy > 10 and enemy != 19 then return "npc_fastzombie"				-- RATHER THAN STEALING THE HARD WORK OF OTHERS ~ Wunce
	elseif enemy == 19 then return "npc_metropolice" 
	else return "npc_metropolice"
end
end
end
end

ammo_drop = true
function killsection(NPC, killer, weap)

if table.HasValue(NPCenemies , NPC) and killer:IsPlayer()  then

if killer.optin == true then
killer.killsection = killer.killsection + 1 --I like this part :P
killer.TotalKills = killer.TotalKills + 1
killer:AddFrags(1)
end

for k,ply in pairs(ents.FindInSphere( NPC:GetPos(), 125 )) do
	if ply != killer and ply:IsPlayer() then
		AltUp(killer, killer.Altruism ,10)
		killer:ChatPrint("You saved "..ply:Nick())
		ply:ChatPrint(killer:Nick().." saved your ass")
	end
end

if NPC.lastattacker and NPC.lastattacker != killer then
AltUp(killer, killer.Altruism ,15)
AltUp(NPC.lastattacker, NPC.lastattacker.Altruism ,12)
end


if npctotalnum > 0 then
npctotalnum = npctotalnum - 1
end


/*----------------------
	Random item drop
----------------------*/
local itemdrop = math.random(1,100)
/*
	if itemdrop > 10 and itemdrop <= 13 then
		entty = ents.Create("first_aid_spray")
	elseif itemdrop > 13 and itemdrop <= 16 then
		entty = ents.Create("ammo_box_pistol")
	elseif itemdrop > 16 and itemdrop <= 19 then
		entty = ents.Create("ammo_box_shotgun")
	elseif itemdrop > 19 and itemdrop <= 21 then
		entty = ents.Create("ammo_box_smg")
	elseif itemdrop == 2 or itemdrop == 3 then
		entty = ents.Create("ammo_box_mach")
	elseif itemdrop >3 and itemdrop <=6 then
		entty = ents.Create("ammo_box_magnum")
	elseif itemdrop == 1 then
		entty = ents.Create("ammo_box_cat")
	end
	*/
	if itemdrop < 15 and ammo_drop then -- NOW YOU GET AMMO FOR GUNS YOU ACTUALLY OWN!!!
	local maybethisgun = {}
	local maxnum = 0
		for k, wep in pairs(killer:GetWeapons()) do
			maybethisgun[k] = wep
			maxnum = maxnum + 1
		end
		if maxnum > 0 then
		local THEGUN = maybethisgun[math.random(1,maxnum)]
		
		if THEGUN:GetClass() == "basic_pistol" then
			entty = ents.Create("ammo_box_pistol")
		elseif THEGUN:GetClass() == "basic_shottie" or THEGUN:GetClass() == "line_shottie" then
			entty = ents.Create("ammo_box_shotgun")
		elseif THEGUN:GetClass() == "beasty_machinegun" or THEGUN:GetClass() == "special_machinegun" then
			entty = ents.Create("ammo_box_mach")
		elseif THEGUN:GetClass() == "cool_ak" then
			entty = ents.Create("ammo_box_smg")
		elseif THEGUN:GetClass() == "beasty_deagle" then
			entty = ents.Create("ammo_box_magnum")
		elseif THEGUN:GetClass() == "catalyst_rifle" then
			entty = ents.Create("ammo_box_cat")
		elseif THEGUN:GetClass() == "grenade_launcher" then
			entty = ents.Create("ammo_box_grenade")
		end	
		end
	elseif (itemdrop == 16 or itemdrop == 17) and ammo_drop then
		entty = ents.Create("first_aid_spray")
	end
	
	
if entty and entty != NULL then
entty:SetPos(NPC:GetPos())
entty:Spawn()
entty:Activate()
timer.Create(string.format("ItemTimer:%i",entty:GetCreationID()), 20 , 1 , ItemRemove, entty)
end
entty = nil
end
end

hook.Add("OnNPCKilled", "killsection", killsection)
/*
function SHAIDstats( ply, text, team )
    if (string.sub(text, 1, 6) == "/SHAID") then
       ply:ChatPrint(string.format("Team Slaughter: %G",slaughter))
	   ply:ChatPrint(string.format("Desired Slaughter: %G",desiredslaughter))
	   ply:ChatPrint(string.format("SHAID NPC's: %i",npctotalnum))
	   local stalkers = 0 
	   for k, NPC in pairs(NPCenemies) do -- I was interested  to see how many were after me and my friend at anyone time
	   if NPC.playertarget == ply then
	   stalkers = stalkers + 1
	   end
	   end
	   ply:ChatPrint(string.format("NPC's chasing you: %i",stalkers))
    end
end
hook.Add( "PlayerSay", "SHAIDstats", SHAIDstats )
*/
function shMenu(ply)
umsg.Start("call_vgui", ply)
umsg.End()
end
concommand.Add("+shmenu",shMenu)

function shMenuclose(ply)
umsg.Start("close_vgui", ply)
umsg.End()
end
concommand.Add("-shmenu",shMenuclose)

function ItemRemove(ent)
if ent != NULL then
ent:Remove()
end
end


function StopTheViolence(NPC)
NPC:AddRelationship("npc_antlion D_LI 99")
NPC:AddRelationship("npc_antlionguard D_LI 99")
NPC:AddRelationship("npc_fastzombie D_LI 99")
NPC:AddRelationship("npc_zombie D_LI 99")
NPC:AddRelationship("npc_headcrab D_LI 99")
NPC:AddRelationship("npc_headcrab_fast D_LI 99")
NPC:AddRelationship("npc_metropolice D_LI 99")
NPC:AddRelationship("npc_antlion_worker D_LI 99") -- almost forgot about the ep2 ones
NPC:AddRelationship("npc_hunter D_LI 99")
end

/*

SHOULDER VIEW
SERVER
BY WUNCE

*/


function SpeedSet(ply) -- this has nothing to do with speed lol
if ply:GetInfoNum("Shoulder_View") == 1 then
ply:CrosshairDisable()
ply:SetViewOffsetDucked(Vector(0,0,60))
else
ply:CrosshairEnable()
ply:SetViewOffsetDucked(Vector(0,0,25))
end
ply.KeyRel = true

		--ply:ChatPrint(ply:GetInfoNum("Shoulder_View"))
end
hook.Add("PlayerSpawn","SpeedSet",SpeedSet)

--hook.Add("PlayerInitialSpawn","InitialCrosshair",SpeedSet)


function hurtanim(ply, attacker, hpl, amt)
ply:ViewPunch(Angle(math.random(-3,3)*(amt/4),math.random(-3,3)*(amt/4),math.random(-3,3)*(amt/4))) --to knock your view around more
ply:SetAnimation( ACT_SMALL_FLINCH) -- doesn't work
end
hook.Add("PlayerHurt","hurtanim",hurtanim)

function CatalystEffect(ply)
	ply.looprar = ply.looprar + 1
activetargets = 0
local culla = 255-(8.5 * ply.looprar)

for k,ent in pairs(ply.Deathents) do

if ent:IsValid() then
ent:SetColor(culla,culla,culla,255)
activetargets = activetargets + 1

				if ply.looprar >= 15 and ply.looprar < 25 then
				ply.ThisRound[k] = ent
				
				elseif ply.looprar >= 30 and table.HasValue(ply.ThisRound,ent) then
				local pos = ent:GetPos()
						/*
							local explode = ents.Create("boom")
							explode:SetPos(pos)
							explode:SetVar("Owner",ply)
							explode:SetVar("Scale",3)
							explode:SetAngles(ent:GetAngles())
							explode:Spawn()
						*/
						local explodee = ents.Create("env_explosion")
						
						explodee:SetPos(pos)
						explodee:Spawn() 
						explodee:SetKeyValue("iMagnitude","0") 
						explodee:Fire("Explode", 0, 0 ) 
						explodee:EmitSound("weapon_AWP.Single", 400, 400 ) --different sound here
						
				
						ent:TakeDamage(1000,ply)
									if ent:IsValid() then
									ent:Remove()
									end
					
						for k,entt in pairs(ents.FindInSphere(pos,500)) do
							if entt:IsNPC() and !table.HasValue(ply.Deathents,entt) then
							ply.increm = ply.increm + 1
							ply.Deathents[ply.increm] = entt
						end
						
				end
				

end
end
end	
if ply.looprar >= 30 then
ply.looprar = 0
end
if activetargets == 0 then
timer.Stop("CatalystDeath")
ply.Deathents = nil 
ply.increm = nil 
ply.looprar = nil
ply.ThisRound = nil
end	

end	

function Defuse(ply, com, arg)
if ExplosiveCharge:IsValid() then
local dist = ply:GetPos()-ExplosiveCharge:GetPos()
local mag = math.sqrt(dist.x * dist.x + dist.y * dist.y + dist.z * dist.z)
	if tonumber(arg[1]) == 2341 and mag < 100 then
		ExplosiveCharge.defused = true
		AltUp(ply, ply.Altruism ,3)
	else
		ply:Kill()
		ply:ChatPrint("Nice try, jackass")
	end
end
end
concommand.Add("Defuse",Defuse)

nextmortartime = 0
nextsupplytime = 0
function Coord_Ability(ply, com, arg)
local ability = tonumber(arg[1])

if ability == 1 and ply:Team() == 1 then
	if coordmarker then
		umsg.Start("ObjMarker", nil)
		umsg.Vector(Vector(0,0,0))
		umsg.End()
		coordmarker = false
	else
	--print("in the right area")
		local pos = Vector(tonumber(arg[2]),tonumber(arg[3]),tonumber(arg[4]))
		local tracedata = {}
		tracedata.start = pos
		tracedata.endpos = Vector(tonumber(arg[2]),tonumber(arg[3]),-15000)
		tracedata.filter = ply
		local trace = util.TraceLine(tracedata)
		
			if trace.Hit then
			umsg.Start("ObjMarker", nil)
			umsg.Vector(trace.HitPos + Vector(0,0,100))
			umsg.End()
			coordmarker = true
			end
		
	end
elseif ability == 2 and ply:Team() == 1 and nextmortartime < CurTime() then
	
	ply:PrintMessage( HUD_PRINTCENTER, "Mortars inbound!" )
	for q=1,5 do
	timer.Simple(5+(q*0.5),function()
	local nade = ents.Create("projectile_grenade")
	nade:SetPos(Vector(tonumber(arg[2])+math.random(-250,250),tonumber(arg[3])+math.random(-250,250),3000))
	nade:SetVar("Owner",ply)
	nade:SetAngles(Angle(-90,0,0))
	nade.red = 1
	nade:Spawn()
	nade:Activate()
	
		local phys = nade:GetPhysicsObject()
			if (phys:IsValid()) then
			phys:AddVelocity(Vector(0,0,-1000))
			end
	
	end)
end
	nextmortartime = CurTime() + 30
elseif ability == 3 and ply:Team() == 1 and nextsupplytime < CurTime() then	
	ply:PrintMessage( HUD_PRINTCENTER, "Incoming supplies" )
	nextsupplytime = CurTime() + 180
	
		timer.Simple(5,function()
	local nade = ents.Create("supply_drop")
	nade:SetPos(Vector(tonumber(arg[2]),tonumber(arg[3]),3000))
	--nade:SetVar("Owner",ply)
	nade:SetAngles(Angle(0,0,0))
	nade:Spawn()
	nade:Activate()
	
		local phys = nade:GetPhysicsObject()
			if (phys:IsValid()) then
			phys:AddVelocity(Vector(0,0,-1000))
			end
	
	end)

elseif ability == 3 and ply:Team() == 1 and nextsupplytime > CurTime() then
local timeleft = math.Round(nextsupplytime - CurTime())
ply:PrintMessage( HUD_PRINTCENTER, timeleft.." seconds before supplies are ready" )
elseif ability == 2 and ply:Team() == 1 and nextmortartime > CurTime() then
local timeleft = math.Round(nextmortartime - CurTime())
ply:PrintMessage( HUD_PRINTCENTER, timeleft.." seconds before mortars are ready" )
	
end
end
concommand.Add("Ability",Coord_Ability)	


