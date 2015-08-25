include( 'shared.lua' )
require "glon"
buybackground = surface.GetTextureID( "zmercs/buymenu" )
helpbground = surface.GetTextureID( "zmercs/help" )
scorebground = surface.GetTextureID( "zmercs/scoreboard" )

language.Add ("CombineCannon_ammo", ".50 Ammo")
language.Add ("AirboatGun_ammo", "5.56MM Ammo")
language.Add ("CombineCannon_ammo", ".50 Ammo")
language.Add ("StriderMinigun_ammo", "7.62MM Ammo")
language.Add ("CombineCannon_ammo", ".50 Ammo")
language.Add ("Gravity_ammo", "4.6MM Ammo")
language.Add ("CombineCannon_ammo", ".50 Ammo")
language.Add ("Battery_ammo", "9MM Ammo")
language.Add ("SniperPenetratedRound_ammo",".45 Ammo")
language.Add ("AlyxGun_ammo" , "5.7MM Ammo")
language.Add ("SniperRound_ammo",".376 Steyr Ammo")


function GM:HUDDrawScoreBoard() 
return false
end

function GM:ScoreboardShow()
Scoreboard = vgui.Create( "DFrame" )
Scoreboard:SetSize( 430, 660 )
Scoreboard:Center()
Scoreboard:SetTitle( "InfoBoard" )
Scoreboard:SetVisible( true )
Scoreboard:SetDraggable( false )
Scoreboard:ShowCloseButton( false )
--Scoreboard:MakePopup()
Scoreboard:SetDraggable( false )
Scoreboard.Paint = function() 
    surface.SetTexture(scorebground) 
	surface.SetDrawColor( 200, 200, 200, 150 )
	surface.DrawTexturedRect( 0, 0, Scoreboard:GetWide(), Scoreboard:GetTall() )  
end

local Heading1= vgui.Create("DLabel", Scoreboard)
Heading1:SetText("Player Name")
Heading1:SetPos(20,20)
Heading1:SetSize(200,20)
Heading1:SetFont("defaultlarge")

local Heading2= vgui.Create("DLabel", Scoreboard)
Heading2:SetText("Altruism")
Heading2:SetPos(220,20)
Heading2:SetSize(50,20)
Heading2:SetFont("defaultlarge")


local Heading3= vgui.Create("DLabel", Scoreboard)
Heading3:SetText("Kills")
Heading3:SetPos(290,20)
Heading3:SetSize(50,20)
Heading3:SetFont("defaultlarge")

local Heading4= vgui.Create("DLabel", Scoreboard)
Heading4:SetText("Ping")
Heading4:SetPos(350,20)
Heading4:SetSize(50,20)
Heading4:SetColor(Color(255,255,255))
Heading4:SetFont("defaultlarge")



scoreboardentry = { {}, {} , {} , {} , {} }
	for k,ply in pairs(player.GetAll()) do
		scoreboardentry[1][k] = ply
	end
	table.sort(scoreboardentry[1], function(a, b) return (a:Frags()*a:Deaths()) < (b:Frags()*b:Deaths()) end)-- doesn't work I think.
	
	for k=1, table.Count(player.GetAll()) do
		scoreboardentry[2][k]= vgui.Create("DLabel", Scoreboard)
		scoreboardentry[2][k]:SetText(scoreboardentry[1][k]:Nick())
		scoreboardentry[2][k]:SetPos(20,(30*k) + 30)
		scoreboardentry[2][k]:SetSize(200,20)


		scoreboardentry[3][k]= vgui.Create("DLabel", Scoreboard)
		scoreboardentry[3][k]:SetText(scoreboardentry[1][k]:Deaths())
		scoreboardentry[3][k]:SetPos(220,(30*k) + 30)
		scoreboardentry[3][k]:SetSize(50,20)

		scoreboardentry[4][k]= vgui.Create("DLabel", Scoreboard)
		scoreboardentry[4][k]:SetText(scoreboardentry[1][k]:Frags())
		scoreboardentry[4][k]:SetPos(290,(30*k) + 30)
		scoreboardentry[4][k]:SetSize(50,20)


		scoreboardentry[5][k]= vgui.Create("DLabel", Scoreboard)
		scoreboardentry[5][k]:SetText(scoreboardentry[1][k]:Ping())
		scoreboardentry[5][k]:SetPos(350,(30*k) + 30)
		scoreboardentry[5][k]:SetSize(50,20)
	end
	
	
	
	
update = CurTime() + 3
Scoreboard.Think = function()
	if update < CurTime() then
	
			
			
				for k=1, table.Count(player.GetAll()) do
				
		 scoreboardentry[3][k]:SetText(scoreboardentry[1][k]:Deaths())
		  scoreboardentry[4][k]:SetText(scoreboardentry[1][k]:Frags())
		   scoreboardentry[5][k]:SetText(scoreboardentry[1][k]:Ping())

				end
			
			
		update = CurTime() + 1
	end
end
end

function GM:ScoreboardHide()
Scoreboard:Close()
end

LocalPlayer().fadetimer = RealTime()
wepsharing = CreateClientConVar( "sh_wepshare", "0", false, true )


function ShowBuyShiz()
MainFrame = vgui.Create( "DFrame" )
MainFrame:SetPos( 50,50 )
MainFrame:SetSize( 556, 556 )
MainFrame:SetTitle( "Order Weapons and Equipment" )
MainFrame:SetVisible( true )
MainFrame:SetDraggable( true )
MainFrame:ShowCloseButton( true )
MainFrame:MakePopup()
MainFrame:SetDraggable( false )
MainFrame.Paint = function() -- Paint function
surface.SetDrawColor( 25, 25, 25, 150 ) 
surface.DrawRect( 0, 0, MainFrame:GetWide(), MainFrame:GetTall() ) 

end

local PropertySheet = vgui.Create( "DPropertySheet", MainFrame )
PropertySheet:SetPos( 22, 22 )
PropertySheet:SetSize( 512, 512 )
PropertySheet.Paint= function() -- The paint function
/*
surface.SetTexture(buybackground) -- this shit will melt your eyes. Fractals for the win!
surface.SetDrawColor( 200, 200, 200, 255 )
surface.DrawTexturedRect( 0, 0, PropertySheet:GetWide(), PropertySheet:GetTall() ) 
*/
end


local CermaPanel = vgui.Create( "DPanel" )
CermaPanel:SetPos( 0, 0 )
CermaPanel:SetSize( 250, 250 )
CermaPanel.Paint = function() -- Paint function
    surface.SetTexture(buybackground) -- this shit will melt your eyes. Fractals for the win!
	surface.SetDrawColor( 200, 200, 200, 255 )
	surface.DrawTexturedRect( 0, 0, CermaPanel:GetWide(), CermaPanel:GetTall() ) 

end

local LermaPanel = vgui.Create( "DPanel" )
LermaPanel:SetPos( 0, 0 )
LermaPanel:SetSize( PropertySheet:GetWide(), PropertySheet:GetTall() )
LermaPanel.Paint = function() -- Paint function
    surface.SetTexture(buybackground) -- this shit will melt your eyes. Fractals for the win!
	surface.SetDrawColor( 200, 200, 200, 255 )
	surface.DrawTexturedRect( 0, 0, LermaPanel:GetWide(),LermaPanel:GetTall() ) 
end

local ShermaPanel = vgui.Create( "DPanel" )
ShermaPanel:SetPos( 0, 0 )
ShermaPanel:SetSize( PropertySheet:GetWide(), PropertySheet:GetTall() )
ShermaPanel.Paint = function() -- Paint function
    surface.SetTexture(buybackground) -- this shit will melt your eyes. Fractals for the win!
	surface.SetDrawColor( 200, 200, 200, 255 )
	surface.DrawTexturedRect( 0, 0, ShermaPanel:GetWide(),ShermaPanel:GetTall() ) 
end

local WermaPanel = vgui.Create( "DPanel" )
WermaPanel:SetPos( 0, 0 )
WermaPanel:SetSize( PropertySheet:GetWide(), PropertySheet:GetTall() )
WermaPanel.Paint = function() -- Paint function
    surface.SetTexture(buybackground) -- this shit will melt your eyes. Fractals for the win!
	surface.SetDrawColor( 200, 200, 200, 255 )
	surface.DrawTexturedRect( 0, 0, WermaPanel:GetWide(),WermaPanel:GetTall() ) 
end


// WEAPONS AND AMMO //
local AK = vgui.Create( "SpawnIcon", Frame)
AK:SetPos( 20, 20 )
AK:SetParent(CermaPanel)
AK:SetModel( "models/weapons/w_rif_ak47.mdl" )
AK:SetToolTip("$120")
AK.DoClick = function ()
    RunConsoleCommand("buy_ak")
end

local AKdesc= vgui.Create("DLabel", CermaPanel)
AKdesc:SetTextColor( Color(255, 255, 255, 255) )
AKdesc:SetFont("tablarge")
AKdesc:SetWrap(true)
AKdesc:SetText("The classic, reliable yet inaccurate AK48. Costs $120.")
AKdesc:SetPos( 94, 20) 
AKdesc:SetSize( 300, 20) 

local AKammo = vgui.Create( "DButton" )
AKammo:SetParent( CermaPanel ) 
AKammo:SetText( "Buy AK Ammo- $15" )
AKammo:SetPos( 94, 45 )
AKammo:SetSize( 200, 20 )
AKammo.DoClick = function ()
   RunConsoleCommand("buy_AK_ammo")
end


local Deagle = vgui.Create( "SpawnIcon", Frame)
Deagle:SetPos( 20, 104 )
Deagle:SetParent(CermaPanel)
Deagle:SetModel( "models/weapons/w_pist_deagle.mdl" )
Deagle:SetToolTip("$200")
Deagle.DoClick = function ()
    RunConsoleCommand("buy_deagle")
end
local Deagdesc= vgui.Create("DLabel", CermaPanel)
Deagdesc:SetTextColor( Color(255, 255, 255, 255) )
Deagdesc:SetFont("tablarge")
Deagdesc:SetText("The powerful handheld Desert Eagle. Costs $200.")
Deagdesc:SetPos( 94, 104) 
Deagdesc:SetSize( 300, 20) 

local DeagAmmo = vgui.Create( "DButton" )
DeagAmmo:SetParent( CermaPanel ) 
DeagAmmo:SetText( "Buy Deagle Ammo- $25" )
DeagAmmo:SetPos( 94, 129 )
DeagAmmo:SetSize( 200, 20 )
DeagAmmo.DoClick = function ()
   RunConsoleCommand("buy_Deagle_ammo")
end

local Shottie = vgui.Create( "SpawnIcon", Frame)
Shottie:SetPos( 20, 188 )
Shottie:SetParent(CermaPanel)
Shottie:SetModel( "models/weapons/w_shot_m3super90.mdl" )
Shottie:SetToolTip("$100")
Shottie.DoClick = function ()
    RunConsoleCommand("buy_shottie")
end
local Shottiedesc= vgui.Create("DLabel", CermaPanel)
Shottiedesc:SetFont("tablarge")
Shottiedesc:SetText("The slow firing, wide spreading shotgun. Costs $100.")
Shottiedesc:SetTextColor( Color(255, 255, 255, 255) )
Shottiedesc:SetPos( 94, 188) 
Shottiedesc:SetSize( 300, 20) 

local ShottieAmmo = vgui.Create( "DButton" )
ShottieAmmo:SetParent( CermaPanel ) 
ShottieAmmo:SetText( "Buy Shottie ammo- $20" )
ShottieAmmo:SetPos( 94, 213 )
ShottieAmmo:SetSize( 200, 20 )
ShottieAmmo.DoClick = function ()
   RunConsoleCommand("buy_Shottie_ammo")
end

local Machine = vgui.Create( "SpawnIcon", Frame)
Machine:SetPos( 20, 272 )
Machine:SetParent(CermaPanel)
Machine:SetModel( "models/weapons/w_mach_m249para.mdl" )
Machine:SetToolTip("$240")
Machine.DoClick = function ()
    RunConsoleCommand("buy_Mach")
end
local Machinedesc= vgui.Create("DLabel", CermaPanel)
Machinedesc:SetFont("tablarge")
Machinedesc:SetText("Rapid fire, Light Machine gun. Costs $240.")
Machinedesc:SetTextColor( Color(255, 255, 255, 255) )
Machinedesc:SetPos( 94, 272) 
Machinedesc:SetSize( 300, 20) 

local MachineAmmo = vgui.Create( "DButton" )
MachineAmmo:SetParent( CermaPanel ) 
MachineAmmo:SetText( "Buy LMG ammo- $40" )
MachineAmmo:SetPos( 94, 297 )
MachineAmmo:SetSize( 200, 20 )
MachineAmmo.DoClick = function ()
   RunConsoleCommand("buy_Mach_ammo")
end


local NadeLauncher = vgui.Create( "SpawnIcon", Frame)
NadeLauncher:SetPos( 20, 360 )
NadeLauncher:SetParent(CermaPanel)
NadeLauncher:SetModel( "models/weapons/w_shotgun.mdl" )
NadeLauncher:SetToolTip("$200")
NadeLauncher.DoClick = function ()
    RunConsoleCommand("buy_nade_launcher")
end
local NadeLauncherdesc= vgui.Create("DLabel", CermaPanel)
NadeLauncherdesc:SetFont("tablarge")
NadeLauncherdesc:SetText("High-Explosive grenade launcher. Costs $200.")
NadeLauncherdesc:SetTextColor( Color(255, 255, 255, 255) )
NadeLauncherdesc:SetPos( 94, 360) 
NadeLauncherdesc:SetSize( 300, 20) 

local NadeLauncherAmmo = vgui.Create( "DButton" )
NadeLauncherAmmo:SetParent( CermaPanel ) 
NadeLauncherAmmo:SetText( "Buy grenades - $40" )
NadeLauncherAmmo:SetPos( 94, 385 )
NadeLauncherAmmo:SetSize( 200, 20 )
NadeLauncherAmmo.DoClick = function ()
   RunConsoleCommand("buy_Nade_ammo")
end

local PistAmmo = vgui.Create( "DButton" )
PistAmmo:SetParent( CermaPanel ) 
PistAmmo:SetText( "Buy Five-Seven Ammo- $10" )
PistAmmo:SetPos( 20, 444 )
PistAmmo:SetSize( 394, 20 )
PistAmmo.DoClick = function ()
   RunConsoleCommand("buy_bpistol_ammo")
end

local FASS = vgui.Create( "SpawnIcon", Frame)
FASS:SetPos( 20, 20  )
FASS:SetParent(LermaPanel)
FASS:SetModel( "models/healthvial.mdl" )
FASS:SetToolTip("$40")
FASS.DoClick = function ()
    RunConsoleCommand("buy_FAS")
end
local FASSdesc= vgui.Create("DLabel", LermaPanel)
FASSdesc:SetTextColor( Color(255, 255, 255, 255) )
FASSdesc:SetFont("tablarge")
FASSdesc:SetWrap(true)
FASSdesc:SetText("First Aid Spray that can be used to heal yourself or teammates. Costs $40.")
FASSdesc:SetPos( 94, 20) 
FASSdesc:SetSize( 400, 40) 

local fullH = vgui.Create( "SpawnIcon", LermaPanel)
fullH:SetPos( 20, 104 )
fullH:SetParent(LermaPanel)
fullH:SetModel( "models/items/healthkit.mdl" )
fullH:SetToolTip("$300")
fullH.DoClick = function ()
    RunConsoleCommand("buy_fheal")
end
local fullHdesc= vgui.Create("DLabel", LermaPanel)
fullHdesc:SetTextColor( Color(255, 255, 255, 255) )
fullHdesc:SetFont("tablarge")
fullHdesc:SetWrap(true) 
fullHdesc:SetText("Large medical kit which restores you to full health. Activated when picked up. Costs $100.")
fullHdesc:SetPos( 94, 104) 
fullHdesc:SetSize( 400, 40) 

local SHMOD = vgui.Create( "SpawnIcon", LermaPanel)
SHMOD:SetPos( 20, 188 )
SHMOD:SetParent(LermaPanel)
SHMOD:SetModel( "models/Items/battery.mdl" )
SHMOD:SetToolTip("$300")
SHMOD.DoClick = function ()
    RunConsoleCommand("buy_shield_module")
end
local SHMODdesc= vgui.Create("DLabel", LermaPanel)
SHMODdesc:SetTextColor( Color(255, 255, 255, 255) )
SHMODdesc:SetFont("tablarge")
SHMODdesc:SetWrap(true) 
SHMODdesc:SetText("Shield Module for your armor. More modules give faster regeneration and stronger shields. Costs $300 per module, can have a maximum of 2.")
SHMODdesc:SetPos( 94, 188) 
SHMODdesc:SetSize( 400, 40) 

local gmask = vgui.Create( "SpawnIcon", Frame)
gmask:SetPos( 20, 272  )
gmask:SetParent(LermaPanel)
gmask:SetModel( "models/weapons/w_defuser.mdl" )
gmask:SetToolTip("$60")
gmask.DoClick = function ()
    RunConsoleCommand("buy_gmask")
end
local gmaskdesc= vgui.Create("DLabel", LermaPanel)
gmaskdesc:SetTextColor( Color(255, 255, 255, 255) )
gmaskdesc:SetFont("tablarge")
gmaskdesc:SetText("Gas Mask which protects against gas and headcrabs. Costs $60.")
gmaskdesc:SetPos( 94, 272) 
gmaskdesc:SetSize( 400, 20) 

local SpecPistol = vgui.Create( "SpawnIcon", Frame)
SpecPistol:SetPos( 20, 20  )
SpecPistol:SetParent(ShermaPanel)
SpecPistol:SetModel( "models/weapons/w_pistol.mdl" )
SpecPistol:SetToolTip("$200")
SpecPistol.DoClick = function ()
    RunConsoleCommand("buy_en_pistol")
end
local SpecPistoldesc= vgui.Create("DLabel", ShermaPanel)
SpecPistoldesc:SetTextColor( Color(255, 255, 255, 255) )
SpecPistoldesc:SetFont("tablarge")
SpecPistoldesc:SetWrap( true) 
SpecPistoldesc:SetText("Energy Pistol with unlimited ammo. Weak and inaccurate if fired fast, costs $200.")
SpecPistoldesc:SetPos( 94, 20) 
SpecPistoldesc:SetSize( 400, 40) 

local CatRifle = vgui.Create( "SpawnIcon", Frame)
CatRifle:SetPos( 20, 104 )
CatRifle:SetParent(ShermaPanel)
CatRifle:SetModel( "models/weapons/w_irifle.mdl" )
CatRifle:SetToolTip("$175")
CatRifle.DoClick = function ()
    RunConsoleCommand("buy_Cat_Rifle")
end
local Catdesc= vgui.Create("DLabel", ShermaPanel)
Catdesc:SetTextColor( Color(255, 255, 255, 255) )
Catdesc:SetFont("tablarge")
Catdesc:SetWrap(true)
Catdesc:SetText("The overpowered catalyst rifle. Shoot one enemy in a group and watch them all get anihilated. Costs $175.")
Catdesc:SetPos( 94, 104) 
Catdesc:SetSize( 300, 44) 

local CatAmmo = vgui.Create( "DButton" )
CatAmmo:SetParent( ShermaPanel ) 
CatAmmo:SetText( "Buy Catalyst Ammo- $30" )
CatAmmo:SetPos( 94, 148 )
CatAmmo:SetSize( 200, 20 )
CatAmmo.DoClick = function ()
   RunConsoleCommand("buy_Cat_ammo")
end


local LineShottie = vgui.Create( "SpawnIcon", Frame)
LineShottie:SetPos( 20, 188 )
LineShottie:SetParent(ShermaPanel)
LineShottie:SetModel( "models/weapons/w_shot_xm1014.mdl" )
LineShottie:SetToolTip("$220")
LineShottie.DoClick = function ()
    RunConsoleCommand("buy_Line_Shottie")
end
local Linedesc= vgui.Create("DLabel", ShermaPanel)
Linedesc:SetTextColor( Color(255, 255, 255, 255) )
Linedesc:SetFont("tablarge")
Linedesc:SetWrap(true)
Linedesc:SetText("Shotgun which fires a horizontal line of bullets. Semi-Automatic and costs $220.")
Linedesc:SetPos( 94, 188) 
Linedesc:SetSize( 300, 44) 

local LineAmmo = vgui.Create( "DButton" )
LineAmmo:SetParent( ShermaPanel ) 
LineAmmo:SetText( "Buy Shotgun Ammo- $20" )
LineAmmo:SetPos( 94, 230 )
LineAmmo:SetSize( 200, 20 )
LineAmmo.DoClick = function ()
   RunConsoleCommand("buy_Shottie_ammo")
end

local TriLMG = vgui.Create( "SpawnIcon", Frame)
TriLMG:SetPos( 20, 272 )
TriLMG:SetParent(ShermaPanel)
TriLMG:SetModel( "models/weapons/w_mach_m249para.mdl" )
TriLMG:SetToolTip("$300")
TriLMG.DoClick = function ()
    RunConsoleCommand("buy_TriLMG")
end
local Tridesc= vgui.Create("DLabel", ShermaPanel)
Tridesc:SetTextColor( Color(255, 255, 255, 255) )
Tridesc:SetFont("tablarge")
Tridesc:SetWrap(true)
Tridesc:SetText("Sends a triangle of bullets wherever you are aiming. Rapid-fire with large clip, costs $300.")
Tridesc:SetPos( 94, 272) 
Tridesc:SetSize( 300, 44) 

local TriAmmo = vgui.Create( "DButton" )
TriAmmo:SetParent( ShermaPanel ) 
TriAmmo:SetText( "Buy LMG Ammo- $40" )
TriAmmo:SetPos( 94, 314 )
TriAmmo:SetSize( 200, 20 )
TriAmmo.DoClick = function ()
   RunConsoleCommand("buy_Mach_ammo")
end
/*
local pistolammo = vgui.Create( "SpawnIcon", Frame)
pistolammo:SetPos( 20, 20 )
pistolammo:SetParent(WermaPanel)
pistolammo:SetModel( "models/Items/BoxSRounds.mdl" )
pistolammo:SetToolTip("$10")
pistolammo.DoClick = function ()
    RunConsoleCommand("buy_bpistol_ammo")
end

local pistolammodesc= vgui.Create("DLabel", WermaPanel)
pistolammodesc:SetFont("tablarge")
pistolammodesc:SetText("Ammo for the basic pistol. Costs $10.")
pistolammodesc:SetTextColor( Color(255, 255, 255, 255) )
pistolammodesc:SetPos( 94, 20) 
pistolammodesc:SetSize( 300, 20)
*/
 
local CLIPV = vgui.Create( "SpawnIcon", WermaPanel)
CLIPV:SetPos( 20, 20 )
CLIPV:SetParent(WermaPanel)
CLIPV:SetModel( "models/weapons/w_eq_eholster.mdl" )
CLIPV:SetToolTip("$150")
CLIPV.DoClick = function ()
    RunConsoleCommand("buy_clip_vest")
end
local CLIPVdesc= vgui.Create("DLabel", WermaPanel)
CLIPVdesc:SetTextColor( Color(255, 255, 255, 255) )
CLIPVdesc:SetFont("tablarge")
CLIPVdesc:SetWrap(true) 
CLIPVdesc:SetText("Vest with more slots for clips. Doubles maximum ammo capacity. Costs $150.")
CLIPVdesc:SetPos( 94, 20) 
CLIPVdesc:SetSize( 400, 40) 

local clipsize = vgui.Create( "SpawnIcon", WermaPanel)
clipsize:SetPos( 20, 104 )
clipsize:SetParent(WermaPanel)
clipsize:SetModel( "models/props/CS_militia/reload_bullet_tray.mdl" )
clipsize:SetToolTip("$50")
clipsize.DoClick = function ()
    RunConsoleCommand("buy_clipen")
end
local clipsizedesc= vgui.Create("DLabel", WermaPanel)
clipsizedesc:SetTextColor( Color(255, 255, 255, 255) )
clipsizedesc:SetFont("tablarge")
clipsizedesc:SetWrap(true) 
clipsizedesc:SetText("Doubles the clipsize of your weapon. Applied to the weapon you are carrying and costs $50.")
clipsizedesc:SetPos( 94, 104) 
clipsizedesc:SetSize( 400, 60) 


local wepstab = vgui.Create( "SpawnIcon", WermaPanel)
wepstab:SetPos( 20, 188 )
wepstab:SetParent(WermaPanel)
wepstab:SetModel( "models/props/CS_militia/reloadingpress01.mdl" )
wepstab:SetToolTip("$75")
wepstab.DoClick = function ()
    RunConsoleCommand("buy_wepstab")
end
local wepstabdesc= vgui.Create("DLabel", WermaPanel)
wepstabdesc:SetTextColor( Color(255, 255, 255, 255) )
wepstabdesc:SetFont("tablarge")
wepstabdesc:SetWrap(true) 
wepstabdesc:SetText("Weapon stabiliser which halves recoil and doubles accuracy. Applied to the weapon you are carrying when you pick it up, costs $75.")
wepstabdesc:SetPos( 94, 188) 
wepstabdesc:SetSize( 400, 60) 

local rapid = vgui.Create( "SpawnIcon", WermaPanel)
rapid:SetPos( 20, 272 )
rapid:SetParent(WermaPanel)
rapid:SetModel( "models/props/CS_militia/reload_scale.mdl" )
rapid:SetToolTip("$75")
rapid.DoClick = function ()
    RunConsoleCommand("buy_rapid")
end
local rapiddesc= vgui.Create("DLabel", WermaPanel)
rapiddesc:SetTextColor( Color(255, 255, 255, 255) )
rapiddesc:SetFont("tablarge")
rapiddesc:SetWrap(true) 
rapiddesc:SetText("Rapid fire attachment which turns weapons fully automatic and increases firing speed. Applied to the weapon you are carrying when you pick it up, costs $75.")
rapiddesc:SetPos( 94, 272) 
rapiddesc:SetSize( 400, 60) 

local holo = vgui.Create( "SpawnIcon", WermaPanel)
holo:SetPos( 20, 360 )
holo:SetParent(WermaPanel)
holo:SetModel( "models/props/kb_mouse/mouse.mdl" )
holo:SetToolTip("$100")
holo.DoClick = function ()
    RunConsoleCommand("buy_holo_info")
end
local holodesc= vgui.Create("DLabel", WermaPanel)
holodesc:SetTextColor( Color(255, 255, 255, 255) )
holodesc:SetFont("tablarge")
holodesc:SetWrap(true) 
holodesc:SetText("Gives you a holographic projector on the side of your head. This means that you have a laser and ammo counter everyone can see. Costs $100.")
holodesc:SetPos( 94, 360) 
holodesc:SetSize( 400, 60) 


PropertySheet:AddSheet( "Basic Weapons", CermaPanel, "gui/silkicons/user", false, false, "Basic, modern weapons" )
PropertySheet:AddSheet( "Special Weapons", ShermaPanel, "gui/silkicons/group", false, false, "Unique, Experimental Weapons" )
PropertySheet:AddSheet( "Health + Armour", LermaPanel, "gui/silkicons/group", false, false, "Health and Armour equipment" )
PropertySheet:AddSheet( "Weapon Mods", WermaPanel, "gui/silkicons/group", false, false, "Modifications for weapons" )




end

function  TeamPanel()
local DermaPanel = vgui.Create( "DFrame" )
DermaPanel:SetPos( 50,50 )
DermaPanel:SetSize( 512, 512 )
DermaPanel:SetTitle( "Select Role" )
DermaPanel:SetVisible( true )
DermaPanel:SetDraggable( true )
DermaPanel:ShowCloseButton( true )
DermaPanel:MakePopup()
DermaPanel:SetDraggable( false )
DermaPanel.Paint = function() -- Paint function

surface.SetTexture(buybackground) -- this shit will melt your eyes. Fractals for the win!
surface.SetDrawColor( 200, 200, 200, 200 )
surface.DrawTexturedRect( 0, 0, DermaPanel:GetWide(), DermaPanel:GetTall() )
surface.SetDrawColor( 255, 255, 255, 150 ) -- How about a dossier texture??
surface.DrawRect( 30, 130, 320, 170 ) 

end

local button1 = vgui.Create( "DButton" )
button1:SetParent( DermaPanel ) 
button1:SetText( "Become the Co-Ordinator" )
button1:SetPos( 20, 20 )
button1:SetSize( 200, 20 )
button1.DoClick = function ()
   RunConsoleCommand("changeteamto", "1")
end

local button2 = vgui.Create( "DButton" )
button2:SetParent( DermaPanel ) 
button2:SetText( "Become a Mercenary" )
button2:SetPos( 20, 50 )
button2:SetSize( 200, 20 )
button2.DoClick = function ()
   RunConsoleCommand("changeteamto", "2")
end
/*
local button3 = vgui.Create( "DButton" )
button3:SetParent( DermaPanel ) 
button3:SetText( "Become a Survivor" )
button3:SetPos( 20, 80 )
button3:SetSize( 200, 20 )
button3.DoClick = function ()
   RunConsoleCommand("changeteamto", "3")
end
*/
	local supalist= vgui.Create( "DMultiChoice", DermaPanel)
	supalist:SetPos(20,100)
	supalist:SetSize( 100, 20 )
			for _,ply in pairs(player.GetAll()) do
			supalist:AddChoice(ply:Nick())
			end	
			
	supalist.OnSelect = function(panel, index, value)
	RunConsoleCommand("retrievestats",value)
	timer.Simple(0.1,updatedossier,value)
	end	
	
	Dossier= vgui.Create("DLabel", DermaPanel)
	Dossier:SetTextColor( Color(0, 0, 0, 255) )
Dossier:SetWrap(true)
Dossier:SetFont("defaultlarge")
Dossier:SetPos( 40, 140) 
Dossier:SetSize( 300, 150) 
Dossier:SetText("Select a mercenary from the list above to view their dossier.")

end
usermessage.Hook( "call_team", TeamPanel )


function updatedossier(nick)
thedossiertext = nil

	if altfact >= 900 then
	thedossiertext = nick.." is an excellent team player and would single handedly take on an antlion guard if it meant saving his team."
	elseif altfact < 900 and altfact >= 750 then
	thedossiertext = nick.." is a good team player and is likely to put the safety of others above his own."
	elseif altfact < 750 and altfact >= 550 then
	thedossiertext = nick.." works well in teams and is likely to co-operate in order to complete objectives."
	elseif altfact < 550 and altfact >= 300 then
	thedossiertext = nick.." will never put himself in danger to save his team but will not shoot them in the ass either."
	else
	thedossiertext = nick.." does not operate well in teams. Avoid where possible."
	end
	
	if objfact < 3 and killfact < 600 then
	thedossiertext = thedossiertext.." Unfortunately he is inexperienced and has not completed many objectives."
	elseif objfact < 3 and killfact >= 600 then
	thedossiertext = thedossiertext.." He struggles to complete objectives even though he has experience in eliminating aliens."
	elseif objfact >= 3 and objfact < 5 then
	thedossiertext = thedossiertext.." He is competant but shouldn't be hired for more difficult objectives."
	elseif objfact >= 5 and objfact < 8 then
	thedossiertext = thedossiertext.." He is very efficient at completing objectives and is therefore excellent for tougher and more complex tasks."
	elseif objfact >= 8 and objfact < 10 then
	thedossiertext = thedossiertext.." Luckily, he is near perfect at completing objectives. It is strongly recomended that you hire this mercenary."
	else
	
	end
	
	if killfact > 100 and killfact <= 600 then
	thedossiertext = thedossiertext.." Even though this merc has little experience, he is quite capable of defending themself."
	elseif killfact > 600 and killfact <= 1500 then
	thedossiertext = thedossiertext..nick.."'s experience gives him an edge on surviving through the toughest of attacks."
	elseif killfact > 1500 and killfact <= 2800 then
	thedossiertext = thedossiertext.." A veteran of the alien battlefield, "..nick.." will kill any alien on sight. Survival is guaranteed. "
	elseif killfact > 2800 and killfact <= 4500 then
	thedossiertext = thedossiertext.." This merc shows signs of nearly super human skill, anhilating every target easily and with minimal risk to himself. "..nick.." will kill everything in their way. "
	elseif killfact > 4500 and killfact <= 10000 then
	thedossiertext = thedossiertext..nick.." has killed so many enemies in such a short space of time. If he co-operates, his skill and experience will allow him to ensure the survival of himself and everyone on his team. "
	elseif killfact > 10000 then
	thedossiertext = thedossiertext.." This is not a merc, it is a genocidal maniac hell-bent on single handedly sending the aliens back to where they came from. Hire immediately- better to keep him on our side. "
	end

Dossier:SetText(thedossiertext)

end

local function STATISTIC( um )
altfact = um:ReadShort() 
objfact = um:ReadFloat()
killfact = um:ReadLong()
end
usermessage.Hook( "STATISTIC", STATISTIC )





function ShowSpecShiz()
if LocalPlayer():Team() == 1 then
specmenu = true
RunConsoleCommand("stopmoving","1")
PlayerChooser = vgui.Create( "DFrame" )
PlayerChooser:SetSize( 170,ScrH() )
PlayerChooser:ShowCloseButton(false)
PlayerChooser:SetPos(0,0)
--PlayerChooser:MakePopup()
PlayerChooser:SetTitle( "Co-Ordinator View" )

CoordScreenX = LocalPlayer():GetPos().x
CoordScreenY = LocalPlayer():GetPos().y
CoordScreenZ = LocalPlayer():GetPos().z + 1500

local button1 = vgui.Create( "DButton" )
button1:SetParent( PlayerChooser ) 
button1:SetText( "Close" )
button1:SetPos( 10, 20 )
button1:SetSize( 150, 20 )
button1.DoClick = function ()
   PlayerChooser:Close()
   specmenu = false
   RunConsoleCommand("stopmoving","0")
   gui.EnableScreenClicker(false)
end

local howto= vgui.Create("DLabel", PlayerChooser)
howto:SetTextColor( Color(255, 255, 255, 255) )
howto:SetFont("default")
howto:SetText("Hold use for cursor.")
howto:SetPos( 10, 50) 
howto:SetSize( 150, 20) 

local howto= vgui.Create("DLabel", PlayerChooser)
howto:SetTextColor( Color(255, 255, 255, 255) )
howto:SetFont("default")
howto:SetText("Press space for support power.")
howto:SetPos( 10, 70) 
howto:SetSize( 150, 20) 



local NumSliderThingy = vgui.Create( "DNumSlider", PlayerChooser )
NumSliderThingy:SetPos( 10,ScrH() - 150 )
NumSliderThingy:SetSize( 150, 100 ) -- Keep the second number at 100
NumSliderThingy:SetText( "Speed" )
NumSliderThingy:SetMin( 5 ) -- Minimum number of the slider
NumSliderThingy:SetMax( 100 ) -- Maximum number of the slider
NumSliderThingy:SetDecimals( 1 ) -- Sets a decimal. Zero means it's a whole number
NumSliderThingy.ValueChanged = function(pSelf, fValue)
     userspeed = fValue
end

local NumSliderThingy = vgui.Create( "DNumSlider", PlayerChooser )
NumSliderThingy:SetPos( 10,ScrH() - 50 )
NumSliderThingy:SetSize( 150, 100 ) -- Keep the second number at 100
NumSliderThingy:SetText( "Height" )
NumSliderThingy:SetMin( 0 ) -- Minimum number of the slider
NumSliderThingy:SetMax( 5000 ) -- Maximum number of the slider
NumSliderThingy:SetDecimals( 1 ) -- Sets a decimal. Zero means it's a whole number
NumSliderThingy.ValueChanged = function(pSelf, fValue)
     CoordScreenZ = fValue + LocalPlayer():GetPos().z
end
/*
Abilities = vgui.Create( "DFrame" ) -- Creates the frame itself
Abilities:SetPos( 2*ScrW()/3,5*ScrH()/6 ) -- Position on the players screen
Abilities:SetSize( ScrW()/3, ScrH()/6 ) -- Size of the frame
Abilities:SetTitle( " " ) -- Title of the frame
Abilities:SetVisible( true )
Abilities:SetDraggable( false ) -- Draggable by mouse?
Abilities:ShowCloseButton( false ) -- Show the close button?
Abilities.Paint = function()
	surface.SetDrawColor(Color(0,0,0,0) ) 
	surface.DrawRect(  0, 0, Abilities:GetWide(), Abilities:GetTall() ) -- Draw the rect
end
*/

local howto= vgui.Create("DLabel", PlayerChooser)
howto:SetTextColor( Color(255, 255, 255, 255) )
howto:SetFont("menularge")
howto:SetText("Support Powers")
howto:SetPos( 10, ScrH()/2-40) 
howto:SetSize( 150, 20) 


local button1 = vgui.Create( "DButton" )
button1:SetParent( PlayerChooser ) 
button1:SetText( "Waypoint" )
button1:SetPos( 10, ScrH()/2-10 )
button1:SetSize( 150, 20 )
button1.DoClick = function ()
CurrentAbility = 1
end

local button1 = vgui.Create( "DButton" )
button1:SetParent( PlayerChooser ) 
button1:SetText( "Mortar Strike" )
button1:SetPos( 10, ScrH()/2+20 )
button1:SetSize( 150, 20 )
button1.DoClick = function ()
CurrentAbility = 2
end

local button1 = vgui.Create( "DButton" )
button1:SetParent( PlayerChooser ) 
button1:SetText( "Supply Drop" )
button1:SetPos( 10, ScrH()/2+50)
button1:SetSize( 150, 20 )
button1.DoClick = function ()
CurrentAbility = 3
end
	/*
	local List= vgui.Create( "DMultiChoice", PlayerChooser) 
	List:SetPos(10,30)
	List:SetSize( 150, 20 )
	List:AddChoice("None")
			for _,ply in pairs(player.GetAll()) do -- NOTE: CHANGE PLAYER.GETALL TO TEAM.GETPLAYERS(2) AFTER DEBUGGING... or should I?
			List:AddChoice(ply:Nick())
			end

	List.OnSelect = function(panel, index, value)
	RunConsoleCommand("stopmoving","1")
	for k,ply in pairs(player.GetAll()) do
		if value == ply:Nick() then
			FIRSTCAMERA = ply
		elseif value == "None" then
			FIRSTCAMERA = nil
		end
	end
	end	

	
			
	local List2= vgui.Create( "DMultiChoice", PlayerChooser)
	List2:SetPos(10,ScrH()/3 + 30)
	List2:SetSize( 150, 20 )
	List2:AddChoice("None")
			for _,ply in pairs(team.GetPlayers(2)) do
			List2:AddChoice(ply:Nick())
			end		
			
	List2.OnSelect = function(panel, index, value)
	RunConsoleCommand("stopmoving","1")
	for k,ply in pairs(team.GetPlayers(2)) do
		if value == ply:Nick() then
			SECCAMERA = ply
		elseif value == "None" then
			SECCAMERA = nil
		end
	end
	end	

	local List3= vgui.Create( "DMultiChoice", PlayerChooser)
	List3:SetPos(10,2*ScrH()/3+30+30)
	List3:SetSize( 150, 20 )
	List3:AddChoice("None")
			for _,ply in pairs(team.GetPlayers(2)) do
			List3:AddChoice(ply:Nick())
			end	
	
	List3.OnSelect = function(panel, index, value)
	RunConsoleCommand("stopmoving","1")
	for k,ply in pairs(team.GetPlayers(2)) do
		if value == ply:Nick() then
			THIRDCAMERA = ply
		elseif value == "None" then
			THIRDCAMERA = nil
		end
	end
	end		
	*/
	PlayerChooser.Paint = function()
surface.SetTexture(scorebground) -- this shit will melt your eyes. Fractals for the win!
surface.SetDrawColor( 255, 255, 255, 255 )
surface.DrawTexturedRect( 0, 0, PlayerChooser:GetWide(), PlayerChooser:GetTall() ) -- Draw the rect

end
	end
	
end



			function usekeyinuse(ply,key) -- change this key perhaps??
			if key == IN_USE and specmenu == true then
			gui.EnableScreenClicker(true)
			end
			end
			hook.Add( "KeyPress", "usekeyinuse", usekeyinuse )
			
			function usekeynotinuse(ply,key)
			if key == IN_USE and specmenu == true then
			gui.EnableScreenClicker(false)
			end
			end
			hook.Add( "KeyRelease", "usekeynotinuse", usekeynotinuse )

local function ReadMoney( um )
Cash =  um:ReadFloat() -- Money money money money; MONEY
end
usermessage.Hook( "rmoney", ReadMoney )


usermessage.Hook( "call_buymenu", ShowBuyShiz )


usermessage.Hook( "call_specmenu", ShowSpecShiz )







wepshare = false
backgroundtex = surface.GetTextureID( "zmercs/background" )

function ShowSHAIDstuffs()
local ply = LocalPlayer()
DermaPanel = vgui.Create( "DFrame" )
DermaPanel:SetPos( 100,100 )
DermaPanel:SetSize( 250, 600 )
DermaPanel:SetTitle( "SHAID operations" )
DermaPanel:SetVisible( true )
DermaPanel:SetDraggable( true )
DermaPanel:ShowCloseButton( false )
DermaPanel:MakePopup()
DermaPanel:SetDraggable( false )
DermaPanel.Paint = function() -- Paint function
    surface.SetDrawColor( 0, 0, 0, 200 ) -- Set our rect color below us; we do this so you can see items added to this panel
    surface.DrawRect( 0, 250, DermaPanel:GetWide(), DermaPanel:GetTall()-250 ) -- Draw the rect
surface.SetTexture(backgroundtex)
surface.SetDrawColor(255,255,255,200)
surface.DrawTexturedRect(0,0,250,250)

end

ExtraPanel = vgui.Create( "DFrame" )
ExtraPanel:SetPos( ScrW() - 350,100 )
ExtraPanel:SetSize( 250, 600 )
ExtraPanel:SetTitle( "Limb_Health operations" )
ExtraPanel:SetVisible( true )
ExtraPanel:SetDraggable( true )
ExtraPanel:ShowCloseButton( false )
ExtraPanel:MakePopup()
ExtraPanel:SetDraggable( false )
ExtraPanel.Paint = function() -- Paint function
    surface.SetDrawColor( 0, 0, 0, 200 ) -- Set our rect color below us; we do this so you can see items added to this panel
    surface.DrawRect( 0, 250, DermaPanel:GetWide(), DermaPanel:GetTall()-250 ) -- Draw the rect
surface.SetTexture(backgroundtex)
surface.SetDrawColor(255,255,255,200)
surface.DrawTexturedRect(0,0,250,250)
end

// SET UP //
local DermaButton1 = vgui.Create( "DButton" ) --give a good name to these so that they are easier to track
DermaButton1:SetParent( DermaPanel ) 
DermaButton1:SetText( "Create Spawn" )
DermaButton1:SetPos( 25, 50 )
DermaButton1:SetSize( 200, 20 )
DermaButton1.DoClick = function ()
	if(ply:IsAdmin() or ply:IsSuperAdmin()) then
    RunConsoleCommand("SHAID_add_spawn")
	end
end

local DermaButton2 = vgui.Create( "DButton" ) 
DermaButton2:SetParent( DermaPanel ) 
DermaButton2:SetText( "Create Objective" )
DermaButton2:SetPos( 25, 75 )
DermaButton2:SetSize( 200, 20 )
DermaButton2.DoClick = function ()
	if(ply:IsAdmin() or ply:IsSuperAdmin()) then
    RunConsoleCommand("SHAID_add_obj")
	end
end

local DermaButton3 = vgui.Create( "DButton" ) 
DermaButton3:SetParent( DermaPanel ) 
DermaButton3:SetText( "Create Buy Zone" )
DermaButton3:SetPos( 25, 100 )
DermaButton3:SetSize( 200, 20 )
DermaButton3.DoClick = function ()
	if(ply:IsAdmin() or ply:IsSuperAdmin()) then
    RunConsoleCommand("SHAID_purchase_drop_location")
	end
end

local DermaButton3 = vgui.Create( "DButton" ) 
DermaButton3:SetParent( DermaPanel ) 
DermaButton3:SetText( "Toggle Ep 2 content" )
DermaButton3:SetPos( 25, 125 )
DermaButton3:SetSize( 200, 20 )
DermaButton3.DoClick = function ()
	if(ply:IsAdmin() or ply:IsSuperAdmin()) then
	
	local eptwo = GetConVarNumber("SHAID_Ep2_critters")
	if eptwo == 1 then eptwo = 0
	else eptwo = 1 end
	
    RunConsoleCommand("SHAID_Ep2_critters", eptwo)
	end
end

local DermaButton1 = vgui.Create( "DButton" ) 
DermaButton1:SetParent( DermaPanel ) 
DermaButton1:SetText( "Remove All Spawns" )
DermaButton1:SetPos( 25, 150 )
DermaButton1:SetSize( 200, 20 )
DermaButton1.DoClick = function ()
	if(ply:IsAdmin() or ply:IsSuperAdmin()) then
    RunConsoleCommand("SHAID_Remove_all_spawns")
	end
end


// OPTIONS //
/*
local CheckBoxThing = vgui.Create( "DCheckBoxLabel", DermaPanel )
CheckBoxThing:SetPos( 25, 160 )
CheckBoxThing:SetText( "Zombies Only" )
	if(ply:IsAdmin() or ply:IsSuperAdmin()) then
CheckBoxThing:SetConVar( "SHAID_Zombies_only" ) -- ConCommand must be a 1 or 0 value
CheckBoxThing:SetValue( 1 )
	end
CheckBoxThing:SizeToContents()

local CheckBoxThing2 = vgui.Create( "DCheckBoxLabel", DermaPanel )
CheckBoxThing2:SetPos( 25,185 )
CheckBoxThing2:SetText( "Antlions Only" )
	if(ply:IsAdmin() or ply:IsSuperAdmin()) then
CheckBoxThing2:SetConVar( "SHAID_Antlions_only" ) -- ConCommand must be a 1 or 0 value
CheckBoxThing2:SetValue( 1 )
	end
CheckBoxThing2:SizeToContents()
*/
if(ply:IsAdmin() or ply:IsSuperAdmin()) then
local NumSliderThingy = vgui.Create( "DNumSlider", DermaPanel )
NumSliderThingy:SetPos( 25,185 )
NumSliderThingy:SetSize( 200, 100 ) -- Keep the second number at 100
NumSliderThingy:SetText( "Middle Number of NPCs" )
NumSliderThingy:SetMin( 5 ) -- Minimum number of the slider
NumSliderThingy:SetMax( 20 ) -- Maximum number of the slider
NumSliderThingy:SetDecimals( 1 ) -- Sets a decimal. Zero means it's a whole number
NumSliderThingy:SetConVar( "SHAID_NPC_volume" ) -- Set the convar
end
// SELF HEAL SECTION //

local Heading1= vgui.Create("DLabel", ExtraPanel)
Heading1:SetText("Click the limb you wish to heal")
Heading1:SetPos( 25, 25) 
Heading1:SetSize( 200, 20) 

local LH_HEAD = vgui.Create( "DButton" ) 
LH_HEAD:SetParent( ExtraPanel ) 
LH_HEAD:SetText( " " )
LH_HEAD:SetPos( 109, 50 )
LH_HEAD:SetSize( 32, 32 )
LH_HEAD.DoClick = function ()
    RunConsoleCommand("Self_Heal", "1")
end

local LH_BODY = vgui.Create( "DButton" ) 
LH_BODY:SetParent( ExtraPanel ) 
LH_BODY:SetText( " " )
LH_BODY:SetPos( 95, 82 )
LH_BODY:SetSize( 60, 120 )
LH_BODY.DoClick = function ()
    RunConsoleCommand("Self_Heal", "2")
end

local LH_LARM = vgui.Create( "DButton" ) 
LH_LARM:SetParent( ExtraPanel ) 
LH_LARM:SetText( " " )
LH_LARM:SetPos( 15, 82 )
LH_LARM:SetSize( 80, 20 )
LH_LARM.DoClick = function ()
    RunConsoleCommand("Self_Heal", "4")
end

local LH_RARM = vgui.Create( "DButton" )
LH_RARM:SetParent( ExtraPanel ) 
LH_RARM:SetText( " " )
LH_RARM:SetPos( 155, 82 )
LH_RARM:SetSize( 80, 20 )
LH_RARM.DoClick = function ()
    RunConsoleCommand("Self_Heal", "5")
end

local LH_LLEG = vgui.Create( "DButton" ) 
LH_LLEG:SetParent( ExtraPanel ) 
LH_LLEG:SetText( " " )
LH_LLEG:SetPos( 95, 202 )
LH_LLEG:SetSize( 24, 120 )
LH_LLEG.DoClick = function ()
    RunConsoleCommand("Self_Heal","6")
end

local LH_RLEG = vgui.Create( "DButton" ) 
LH_RLEG:SetParent( ExtraPanel ) 
LH_RLEG:SetText( " " )
LH_RLEG:SetPos( 131, 202 )
LH_RLEG:SetSize( 24, 120 )
LH_RLEG.DoClick = function ()
    RunConsoleCommand("Self_Heal", "7")
end

local DermaButton3 = vgui.Create( "DButton" ) 
DermaButton3:SetParent( ExtraPanel ) 
DermaButton3:SetText( "Toggle thirdperson" )
DermaButton3:SetPos( 25, 340 )
DermaButton3:SetSize( 200, 20 )
DermaButton3.DoClick = function ()
    Shoulder_View = !Shoulder_View
	LocalPlayer():ChatPrint("Over the shoulder camera: "..tostring(Shoulder_View))
end

local DermaButton3 = vgui.Create( "DButton" ) 
DermaButton3:SetParent( ExtraPanel ) 
DermaButton3:SetText( "Toggle first person ragdoll" )
DermaButton3:SetPos( 25, 365 )
DermaButton3:SetSize( 200, 20 )
DermaButton3.DoClick = function ()
    fpsmackwoo = !fpsmackwoo
	LocalPlayer():ChatPrint("First person ragdoll: "..tostring(fpsmackwoo))
end

local DermaButton3 = vgui.Create( "DButton" ) 
DermaButton3:SetParent( ExtraPanel ) 
DermaButton3:SetText( "Toggle Crosshair" )
DermaButton3:SetPos( 25, 390 )
DermaButton3:SetSize( 200, 20 )
DermaButton3.DoClick = function ()
    haircross = !haircross
	LocalPlayer():ChatPrint("Crosshair: "..tostring(haircross))
end


local DermaButton3 = vgui.Create( "DButton" ) 
DermaButton3:SetParent( ExtraPanel ) 
DermaButton3:SetText( "Toggle Weapon Sharing" )
DermaButton3:SetPos( 25, 415 )
DermaButton3:SetSize( 200, 20 )
DermaButton3.DoClick = function ()
    RunConsoleCommand("sh_wepsharing")
end
end

function closepanel()
DermaPanel:Close()
ExtraPanel:Close()
end
usermessage.Hook( "call_vgui", ShowSHAIDstuffs )
usermessage.Hook( "close_vgui", closepanel )




/*
LIMB HEALTH
CLIENT
BY WUNCE
*/


WORKDAMNIT = false

function Inaccuracy(UCMD)
if LocalPlayer().leftarm != nil and LocalPlayer().rightarm != nil then
local aimspaz =  0.01*(50 - (LocalPlayer().leftarm + LocalPlayer().rightarm))
local speedofspaz = (50 - (LocalPlayer().leftarm + LocalPlayer().rightarm))
if WORKDAMNIT == true then
UCMD:SetViewAngles(UCMD:GetViewAngles() + Angle(aimspaz * math.sin(0.17*speedofspaz*CurTime()), aimspaz * math.sin(0.13*speedofspaz*CurTime()),0))
end
end
end
hook.Add("CreateMove", "Inaccuracy", Inaccuracy)






function PostProcess()

if LocalPlayer().head != nil then
	if LocalPlayer().head == 0 then
		DrawMotionBlur( 0.1, 0.79, 0.05 )  
	elseif slowmo then
		DrawMotionBlur( 0.2, 0.99, 0 )
	end
end

end
hook.Add( "RenderScreenspaceEffects", "ClusterFucked", PostProcess )  -- I didn't change the unique name from the wiki becaues it gave me a chuckle


function hidehud(name)
	for k, v in pairs{"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo","CHudDamageIndicator","CHudDeathNotice"} do --,"CHudWeaponSelection"
		if name == v then return false end
	end
end
hook.Add("HUDShouldDraw", "hidehud", hidehud)

LARM = surface.GetTextureID( "zmercs/LARM" )
LLEG = surface.GetTextureID( "zmercs/LLEG" )
RARM = surface.GetTextureID( "zmercs/RARM" )
RLEG = surface.GetTextureID( "zmercs/RLEG" )
BODY = surface.GetTextureID( "zmercs/BODY" )
HEAD = surface.GetTextureID( "zmercs/HEAD" )
SHIELD = surface.GetTextureID( "zmercs/SHIELD" )
BANNER = surface.GetTextureID( "zmercs/objectivebanner" )
waypoint = surface.GetTextureID( "zmercs/zmercwaypoint2" )
ring = surface.GetTextureID( "zmercs/redring" )
veins = surface.GetTextureID( "zmercs/veins" )
static = surface.GetTextureID( "zmercs/staticeffect" )
xhair = surface.GetTextureID( "zmercs/crosshaircircle" )

surface.CreateFont ( "arial black", 20, 300, true, false, "A20", false)

function LimbHealthPaint() -- this is where the little man is drawn :D
local client = LocalPlayer()

if specmenu then

	/*if FIRSTCAMERA then 
	local CamData = {}
	local newang = FIRSTCAMERA:GetAimVector():Angle()
	CamData.angles = newang 
	CamData.origin = FIRSTCAMERA:GetPos() - (newang:Forward() * 80) + (newang:Right() * 25) + (newang:Up() * 40)
	CamData.x = 170
	CamData.y = 0
	CamData.w = ScrH() / 3
	CamData.h = ScrH() / 3
	render.RenderView( CamData )
	end
	
	if SECCAMERA then
	local CamData = {}
	local newang = SECCAMERA:GetAimVector():Angle()
	CamData.angles = newang 
	CamData.origin = SECCAMERA:GetPos() - (newang:Forward() * 80) + (newang:Right() * 25) + (newang:Up() * 40)
	CamData.x = 170
	CamData.y = ScrH() / 3
	CamData.w = ScrH() / 3
	CamData.h = ScrH() / 3
	render.RenderView( CamData )
	end
	
	if THIRDCAMERA then
	local CamData = {}
	local newang = THIRDCAMERA:GetAimVector():Angle()
	CamData.angles = newang 
	CamData.origin = THIRDCAMERA:GetPos() - (newang:Forward() * 80) + (newang:Right() * 25) + (newang:Up() * 40)
	CamData.x = 170
	CamData.y = 2*ScrH() / 3
	CamData.w = ScrH() / 3
	CamData.h = ScrH() / 3
	render.RenderView( CamData )
	end*/
	
	
	// STATIC DRAW >:D //
	
	
	surface.SetTexture( static )
	surface.SetDrawColor(Color(255,255,255,75))
	surface.DrawTexturedRect(0,0, ScrW(), ScrH())
	
	// SMALL CROSSHAIR DRAW //
	surface.SetTexture( xhair )
	surface.SetDrawColor(Color(255,255,255,255))
	surface.DrawTexturedRect(ScrW()/2-25,ScrH()/2-25, 50, 50)
else

// HEALTH HUD DRAW //
if client.leftarm != nil then
surface.SetTexture( LARM )
surface.SetDrawColor(GreentoRed(client.leftarm, 25,150))
surface.DrawTexturedRect((ScrW()/6)-42.2,ScrH()-130, 43.2, 7.5)
surface.SetTexture( LLEG )
surface.SetDrawColor(GreentoRed(client.leftleg, 25,150))
surface.DrawTexturedRect((ScrW()/6)-12.6,ScrH()-84.7, 25.8, 45.3)
surface.SetTexture( RARM )
surface.SetDrawColor(GreentoRed(client.rightarm, 25,150))
surface.DrawTexturedRect((ScrW()/6)+26.1,ScrH()-130, 43.2, 7.5)
surface.SetTexture( RLEG )
surface.SetDrawColor(GreentoRed(client.rightleg, 25,150))
surface.DrawTexturedRect((ScrW()/6)+13,ScrH()-84.7, 25.8, 45.3)
surface.SetTexture( BODY )
surface.SetDrawColor(GreentoRed(client.body, 60,150))
surface.DrawTexturedRect((ScrW()/6),ScrH()-130, 26.1, 45.3)
surface.SetTexture( HEAD )
surface.SetDrawColor(GreentoRed(client.head, 10,150))
surface.DrawTexturedRect((ScrW()/6)+4,ScrH()-148, 18,18)


if client:Armor() > 0 and client:Armor() <= 50 then
	local q = client:Armor()*1.3
	surface.SetTexture( SHIELD )
	surface.SetDrawColor(Color(0,100,200,150))
	surface.DrawTexturedRect((ScrW()/6)+13.05-q,ScrH()-95.2-q, 2*q,2*q)
	
elseif client:Armor() > 50 and client:Armor() <=100 then
	local q = (client:Armor() - 50)*1.3
	surface.SetTexture( SHIELD )
	surface.SetDrawColor(Color(100,40,120,150))
	surface.DrawTexturedRect((ScrW()/6)+13.05-q,ScrH()-95.2-q, 2*q,2*q)
	
end



end

// CASH DRAW! //
if Cash != nil then
draw.SimpleText(string.format("$%i",Cash), "A20", (ScrW()/5)+50, ScrH() - 50, Color(255,255,0,200), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

end


// FIRST AID SPRAY DRAW //
if client.SprayAmt != nil then
for q=1, client.SprayAmt do
draw.RoundedBox(2, (ScrW()/5) + (20*q)+35, ScrH() - 90 , 15 , 30 , Color(255, 255, 255, 150) ) -- don't forget that this is in a loop, so fix it to make it spread out
draw.RoundedBox(2, (ScrW()/5) +4.5 + (20*q)+35, ScrH() - 96 , 6 , 6 , Color(255, 255, 255, 150) )
draw.RoundedBox(0, (ScrW()/5) +5.5 + (20*q)+35, ScrH() - 71 , 4 , 10 , Color(255, 0, 0, 200) )
draw.RoundedBox(0, (ScrW()/5) + 2.5 + (20*q)+35 , ScrH() - 68 , 10 , 4 , Color(255, 0, 0, 200) )
end
end

// AMMO DRAW //
if client:GetActiveWeapon() != NULL then
local ammo = GetCurClip()
local ammotype = client:GetActiveWeapon():GetPrimaryAmmoType()
local curclipsize = client.clipsize

if curclipsize == -1 and ammotype == -1 then 
	--do nothing :D, for now
elseif (ammotype != -1 and curclipsize == -1) or (curclipsize and curclipsize <= 3) then

	if ammo > 15 then
	draw.RoundedBoxEx(2, (ScrW()/5)+50, ScrH() - 130 , 4 , 15 , Color(200, 200, 0, 150), true , true  , false , false )
	draw.SimpleText(string.format("x %i",ammo), "MenuLarge", (ScrW()/5) + 65, ScrH() - 122, Color(200, 200, 0, 150), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	else
	for q=1, ammo do
	draw.RoundedBoxEx(2, (ScrW()/5)+50 + (5*q), ScrH() - 130 , 4 , 15 , Color(200, 200, 0, 150), true , true  , false , false )
	end
	end

elseif curclipsize and curclipsize > 3 then

	local clippydraw = math.floor(ammo/curclipsize)
	if clippydraw > 8 then

	draw.SimpleText(string.format("x %i",clippydraw), "MenuLarge", (ScrW()/5) + 65, ScrH() - 122, Color(0, 50, 200, 150), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	draw.RoundedBox(2, (ScrW()/5) + 50, ScrH() - 130 , 10 , 25 , Color(0, 50, 200, 150) )
	
	else
	
	for q=1, clippydraw do
	draw.RoundedBox(2, (ScrW()/5) + 45  + (12*q), ScrH() - 130 , 10 , 25 , Color(0, 50, 200, 150) ) --make it so that broken clips have individual bullets
	end
	
	end
end
end


// TIMER DRAW >:3 //
if LocalPlayer().Timer then
	surface.SetTexture( BANNER )
	surface.SetDrawColor(Color(0,0,0,150))
	surface.DrawTexturedRect(ScrW()/2-50,12.5,100,25)
	
	local timeleft = math.floor(LocalPlayer().Timer - CurTime())
	if timeleft < 0 then
	timeleft = 0 
		if LocalPlayer().Timer + 5 < CurTime() then
		LocalPlayer().Timer = nil
		end
	end
	
	local min = (timeleft - (timeleft % 60))/60
	local sec = timeleft % 60
	
	if sec > 9 then
	draw.SimpleText(string.format("%i:%i",min,sec), "MenuLarge", ScrW()/2, 23, Color(255,255,255,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	else
	draw.SimpleText(string.format("%i:0%i",min,sec), "MenuLarge", ScrW()/2, 23, Color(255,255,255,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end




// VEINY DRAW //
if client:Health() >= 25 and client:Health() < 75 then
	local transss = 150-((client:Health() - 25)*3)
	surface.SetTexture( ring )
	surface.SetDrawColor(Color(255,255,255,transss))
	surface.DrawTexturedRect(0,0,ScrW(),ScrH())
elseif client:Health() < 25 then
local pi = 3.14159
	local transss = ((math.sin((pi* RealTime())/2)+math.sin((pi* RealTime())*1.5)) *50) + 150
	if transss < 150 then transss = 150 end
	
				surface.SetTexture( ring )
			surface.SetDrawColor(Color(255,255,255,transss))
			surface.DrawTexturedRect(0,0,ScrW(),ScrH())
			
				surface.SetTexture( veins )
			surface.SetDrawColor(Color(160,150,210,(transss-25)))
			surface.DrawTexturedRect(0,0,ScrW(),ScrH())
end

end




// OBJECTIVE BANNER DRAW //
if LocalPlayer().fadetimer and LocalPlayer().fadetimer > RealTime() then
	local sweetcol = FADEOUT(LocalPlayer().ObjColour,LocalPlayer().fadetimer - RealTime(),200)
	local textcol = FADEOUT(4,LocalPlayer().fadetimer - RealTime(),255)
	surface.SetTexture( BANNER )
	surface.SetDrawColor(sweetcol)
	surface.DrawTexturedRect(ScrW()/2-200,ScrH()/2-200,400,100)
	
	local texty = ""
if LocalPlayer().ObjColour == 1 then 
	texty = "NEW OBJECTIVE"
elseif LocalPlayer().ObjColour == 2	then
	texty = "OBJECTIVE FAILED"
else
	texty = "OBJECTIVE COMPLETE"
end
	draw.SimpleText(texty, "MenuLarge", ScrW()/2, ScrH()/2-180, textcol, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleText(LocalPlayer().Objective, "MenuLarge", ScrW()/2, ScrH()/2 - 160, textcol, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)



end
// WAYPOINT DRAW :D //
for k, tm in pairs(player.GetAll()) do
	if tm != LocalPlayer() then
		WaypointDraw(tm, tm:GetPos())
	
	end
end
for k , NPC in pairs(ents.FindByClass("npc_kleiner")) do
	WaypointDraw(NPC, NPC:GetPos())
end
if ObjectiveLocale then
	WaypointDraw(NULL, ObjectiveLocale )
end
end
hook.Add("HUDPaint", "LimbHealthPaint", LimbHealthPaint)


function WaypointDraw(tm, tmpos)
		local pos = tmpos + Vector(0, 0, 70)
		local screenpos = pos:ToScreen()
		surface.SetTexture( waypoint )
	if tm:IsValid() and tm:IsPlayer() then
		if tm:Alive() then
		surface.SetDrawColor(GreentoRed(tm:Health(), 100,150))
		else
		surface.SetDrawColor(Color(0, 0, 0, 150))
		end
	else
		surface.SetDrawColor(Color(75, 150, 230, 150))
	end
		surface.DrawTexturedRect(screenpos.x -10,screenpos.y - 30, 20, 30) --THE WAYPOINT ITSELF
		
end


function GreentoRed(limb, max,opac)
	local multi = 255 / (max/2)
	if limb > (max/2) then
		Colour = Color(255-multi*(limb), 255, 0, opac )
	else
		Colour = Color(255, multi*(limb), 0, opac)
	end
	return Colour
end

function FADEOUT(col,fade,opac)
local transs = opac

if fade > 6 then
transs = ((8-fade)*(opac/2))

elseif fade < 2 then
transs = opac-((2- fade)*(opac/2))

end

if col == 1 then
		return Color(0,100,200,transs)
elseif col == 2 then
		return Color(200,100,100,transs)
elseif col == 4 then
		return Color(230,230,230,transs)
else 
		return Color(0,200,50,transs)
end

end


function localthink()
local ply = LocalPlayer()
	if !deathecho and ply:Health() <= 25 then
		ply:SetDSP( 31, false )
		deathecho = true
	elseif deathecho and ply:Health() > 25 then
		ply:SetDSP( 0, false )
		deathecho = false
	end
end
hook.Add("Think", "localthink" , localthink)

local function RedObjPopup( um )
LocalPlayer().Objective = glon.decode(um:ReadString())
LocalPlayer().fadetimer = RealTime() + 8
LocalPlayer().ObjColour = 2
end
usermessage.Hook( "OBJFAILURE", RedObjPopup )

local function BlueObjPopup( um )
LocalPlayer().Objective = glon.decode(um:ReadString())
LocalPlayer().fadetimer = RealTime() + 8
LocalPlayer().ObjColour = 1
end

usermessage.Hook( "NEWOBJ", BlueObjPopup )


local function GreenObjPopup( um )
LocalPlayer().Objective = glon.decode(um:ReadString())
LocalPlayer().fadetimer = RealTime() + 8
LocalPlayer().ObjColour = 3
end

usermessage.Hook( "OBJSUCCESS", GreenObjPopup )


local function LeftArm( um )
LocalPlayer().leftarm =  um:ReadShort()
end
usermessage.Hook( "LeftArm", LeftArm )

local function RightArm( um )
LocalPlayer().rightarm =  um:ReadShort()
end
usermessage.Hook( "RightArm", RightArm )

local function LeftLeg( um )
LocalPlayer().leftleg =  um:ReadShort()
end
usermessage.Hook( "LeftLeg", LeftLeg )

local function RightLeg( um )
LocalPlayer().rightleg =  um:ReadShort()
end
usermessage.Hook( "RightLeg", RightLeg )

local function Head( um )
LocalPlayer().head =  um:ReadShort()
end
usermessage.Hook( "Head", Head )

local function Body( um )
LocalPlayer().body =  um:ReadShort()
end
usermessage.Hook( "Body", Body )

local function Timer( um )
LocalPlayer().Timer =  um:ReadFloat()
end
usermessage.Hook( "Timer", Timer )


local function SprayAmt( um )
LocalPlayer().SprayAmt =  um:ReadFloat() -- a white can with a red cross
end
usermessage.Hook( "SprayAmt", SprayAmt )

local function clipsize( um )
LocalPlayer().clipsize =  um:ReadFloat() -- a blue rectange. This really should be a texture.
end
usermessage.Hook( "clipsize", clipsize )

local function slomoblur( um )
slowmo =  um:ReadBool() 
end
usermessage.Hook( "SlowMotion", slomoblur )

local function ObjMarker( um )
ObjectiveLocale =  um:ReadVector()
	if ObjectiveLocale == Vector(0,0,0) then
		ObjectiveLocale = nil
	end
end
usermessage.Hook( "ObjMarker", ObjMarker )


LasClip = {}

function ClipSend( um ) -- for creating this, I'm pretty sure I'm a fucking genius... unless its really laggy.
local ID = um:ReadShort()
local clip = um:ReadLong()
LasClip[ID] = clip
end
usermessage.Hook( "ClipSend", ClipSend )

function GetCurClip()
local client = LocalPlayer()
local actwep = client:GetActiveWeapon()
if actwep == NULL then return -1 end
if ( ! actwep ) then return -1 end
 
	return client:GetAmmoCount(actwep:GetPrimaryAmmoType())

	
	end
	
	
/*

SHOULDER VIEW
CLIENT
BY WUNCE

*/



Shoulder_View = true
fpsmackwoo = false

function MyCalcView(ply, pos, angles, fov)
local rdoll = LocalPlayer():GetNWEntity("raggy")
if (rdoll != NULL and rdoll != nil) and fpsmackwoo then

local ID = rdoll:LookupAttachment("eyes")
local ragviewpos = rdoll:GetAttachment(ID).Pos
local ragviewang = rdoll:GetAttachment(ID).Ang
local view = {}
    view.origin = ragviewpos+(ragviewang:Forward()*2)
    view.angles = ragviewang
    view.fov = fov
	return view
elseif Shoulder_View and (rdoll == NULL or rdoll == nil) and !specmenu then
	
	if LocalPlayer().zoomtime == nil then
	LocalPlayer().zoomtime = CurTime()
	LocalPlayer().zoomc = 0
	end
	if LocalPlayer().zoomtime and LocalPlayer().zoomtime < CurTime() then
	LocalPlayer().zoomc = 0 
	else
	LocalPlayer().zoomc = LocalPlayer().zoomtime - CurTime()
	end
	
	if (!LocalPlayer():InVehicle()) then
				local tracedata = {}
				tracedata.start = pos
				tracedata.endpos = pos-(angles:Forward()*90)
				tracedata.filter = ply
				tracedata.mask = MASK_SOLID_BRUSHONLY
			local trace = util.TraceLine(tracedata)
				local tracedataR = {}
				tracedataR.start = pos
				tracedataR.endpos = pos+(angles:Right()*50)
				tracedataR.filter = ply
				tracedataR.mask = MASK_SOLID_BRUSHONLY
			local traceR = util.TraceLine(tracedataR)
			
			
		local view = {}
		view.angles = angles
		view.fov = fov
	if LocalPlayer().KeyRel == false then
		if trace.Hit then
			view.origin = pos-(angles:Forward()*80*trace.Fraction)+(angles:Right()*25*traceR.Fraction)
		else
			view.origin = pos-(angles:Forward()*(80 - (80*LocalPlayer().zoomc)))+(angles:Right()*25*traceR.Fraction) -- the right part isn't quite working
		end

		return view
	else
		if trace.Hit then
			view.origin = pos-(angles:Forward()*40*trace.Fraction)+(angles:Right()*25*traceR.Fraction)
		else
			view.origin = pos-(angles:Forward()*(40 + (80*LocalPlayer().zoomc)))+(angles:Right()*25*traceR.Fraction)
		end

		return view
	end
end

		elseif specmenu and (rdoll == NULL or rdoll == nil) then
		local view = {}
		view.angles = Angle(90,0,0)
		view.fov = fov
		view.origin = Vector(CoordScreenX, CoordScreenY, CoordScreenZ)
		return view
end
end
hook.Add("CalcView", "MyCalcView", MyCalcView)
 
 
/*----------------------------
	Client Think Section
----------------------------*/ 
		movetype = 0
		fastcammove = false
		userspeed = 60
function zmercthink() -- ADD ROTATION LATER. MAKE A SLIDER SO THAT THE PLAYER CAN CHANGE THEIR SPEED!!! if I don't, there will be issues with fast fps
local camspeed = userspeed

if specmenu then

if fastcammove then
camspeed = userspeed * 2
end
if movetype == 1 then 
	local direction = Vector(1,0,0)
	CoordScreenX = (camspeed* direction.x) + CoordScreenX
	CoordScreenY = (camspeed* direction.y) + CoordScreenY
elseif movetype == 2 then
	local direction = Vector(1,0,0)
	CoordScreenX = CoordScreenX - (camspeed* direction.x)
	CoordScreenY = CoordScreenY - (camspeed* direction.y)
elseif movetype == 3 then
	local direction = Vector(0,1,0)
	CoordScreenX = CoordScreenX - (camspeed* direction.x)
	CoordScreenY = CoordScreenY - (camspeed* direction.y)
elseif movetype == 4 then
	local direction = Vector(0,1,0)
	CoordScreenX = CoordScreenX + (camspeed* direction.x)
	CoordScreenY = CoordScreenY + (camspeed* direction.y)
end

end
end
hook.Add("Think", "zmercthink", zmercthink) 
 
 
 
function MoveCoordCam(ply, key)
if specmenu then
		if key == IN_FORWARD then
		movetype = 1
		elseif key == IN_BACK then
		movetype = 2
		elseif key == IN_MOVERIGHT then
		movetype = 3
		elseif key == IN_MOVELEFT then
		movetype = 4
		elseif key == IN_SPEED then
		fastcammove = true
		elseif key == IN_JUMP and CurrentAbility then
		RunConsoleCommand("Ability",tostring(CurrentAbility),tostring(CoordScreenX),tostring(CoordScreenY),tostring(CoordScreenZ))
		end
else
		if key == IN_ATTACK then
		WORKDAMNIT = true
		elseif key == IN_SPEED then
		LocalPlayer().KeyRel = false
		LocalPlayer().zoomtime = CurTime() + 0.5
		end

end
end
hook.Add("KeyPress", "MoveCoordCam", MoveCoordCam) 
 
 
 
function MoveCoordCamEnd(ply, key)
if specmenu then

		if key == IN_FORWARD and movetype == 1 then
		movetype = 0
		elseif key == IN_BACK and movetype == 2 then
		movetype = 0
		elseif key == IN_MOVERIGHT and movetype == 3 then
		movetype = 0
		elseif key == IN_MOVELEFT and movetype == 4 then
		movetype = 0
		elseif key == IN_SPEED then
		fastcammove = false
		end
		
else

		if key == IN_ATTACK then
		WORKDAMNIT = false
		elseif key == IN_SPEED then
		LocalPlayer().KeyRel = true
		LocalPlayer().zoomtime = CurTime() + 0.5
		end

end
end
hook.Add("KeyRelease", "MoveCoordCamEnd", MoveCoordCamEnd) 
 
CrossCrossHairSweps = {
"basic_pistol",
"beasty_deagle",
"catalyst_rifle" }
 
function ZmercCrosshair(ply)
	if LocalPlayer():GetActiveWeapon() != NULL and haircross then


		
			local t = util.GetPlayerTrace(LocalPlayer())
			local tr = util.TraceLine(t)

			cam.Start3D(EyePos(), EyeAngles())
			
			local crosswidth = 30
			local crossheight = 30
			
			if LocalPlayer():GetActiveWeapon():GetClass() == "line_shottie" then
				render.SetMaterial(Material("zmercs/crosshairline"))
				crosswidth = 60
				crossheight = 10
			elseif table.HasValue(CrossCrossHairSweps,LocalPlayer():GetActiveWeapon():GetClass()) then
				render.SetMaterial(Material("zmercs/crosshaircross"))
			
			elseif LocalPlayer():GetActiveWeapon():GetClass() == "special_machinegun" then
				render.SetMaterial(Material("zmercs/crosshairtriangle"))
				
			else
				render.SetMaterial(Material("zmercs/crosshairsquare"))

			end
				
				
				if tr.HitNormal == Vector(0,0,1) or tr.HitNormal == Vector(0,0,-1) then
					local rotate = LocalPlayer():GetAimVector():Angle().y
					render.DrawQuadEasy(tr.HitPos, tr.HitNormal:GetNormal(), crosswidth, crossheight, Color(250,50,50,200), rotate)
				else
					render.DrawQuadEasy(tr.HitPos, tr.HitNormal:GetNormal(), crosswidth, crossheight, Color(250,50,50,200), 180)
				end
				
			cam.End3D()
		end
	end

hook.Add("HUDPaint","ZmercCrosshair",ZmercCrosshair)

hook.Add("ShouldDrawLocalPlayer", "MyHax ShouldDrawLocalPlayer", function(ply)
        if LocalPlayer():InVehicle() or !Shoulder_View then
		return false
		else
		return true
		end
end)
/*
local function KeyRel( um )

end
usermessage.Hook( "KeyRel", KeyRel )
*/
local function wRag( um )
LocalPlayer().doll =  um:ReadString()
print(LocalPlayer().doll)
end
usermessage.Hook( "wRag", wRag )


function HELPME()
CurrentPage = 1

HelpFrame = vgui.Create( "DFrame" )
HelpFrame:SetSize( 800,600 )
HelpFrame:Center()
HelpFrame:SetTitle( "Help Menu" )
HelpFrame:SetVisible( true )
HelpFrame:SetDraggable( false )
HelpFrame:ShowCloseButton( true )
HelpFrame:MakePopup()
HelpFrame:SetDraggable( false )
HelpFrame.Paint = function() -- Paint function

    surface.SetTexture(helpbground) -- this shit will melt your eyes. Fractals for the win!
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect(0,0,HelpFrame:GetWide(),HelpFrame:GetTall())
/*
surface.SetDrawColor( 25, 25, 25, 150 ) 
surface.DrawRect( 0, 0, HelpFrame:GetWide(), HelpFrame:GetTall() ) 
*/
end
pg1= vgui.Create("DLabel", HelpFrame)
pg1:SetTextColor( Color(0, 0, 0, 255) )
pg1:SetWrap(false)
pg1:SetFont("default")
pg1:SetPos( 20, 20) 
pg1:SetSize( 560, 300) 
ChangeText()

local ChoiceA = vgui.Create( "DButton" )
ChoiceA:SetParent( HelpFrame ) 
ChoiceA:SetText( "Next" )
ChoiceA:SetPos( 480, 350 )
ChoiceA:SetSize( 100, 20 )
ChoiceA.DoClick = function ()
   CurrentPage = CurrentPage + 1
   if CurrentPage > 7 then CurrentPage = 7 end
   ChangeText()
end

local ChoiceB = vgui.Create( "DButton" )
ChoiceB:SetParent( HelpFrame ) 
ChoiceB:SetText( "Back" )
ChoiceB:SetPos( 20, 350 )
ChoiceB:SetSize( 100, 20 )
ChoiceB.DoClick = function ()
   CurrentPage = CurrentPage - 1
   if CurrentPage < 1 then CurrentPage = 1 end
   ChangeText()
end

local close= vgui.Create( "DButton" )
close:SetParent( HelpFrame ) 
close:SetText( "Close" )
close:SetPos( 250, 350 )
close:SetSize( 100, 20 )
close.DoClick = function ()
HelpFrame:Close()
end
end	
usermessage.Hook( "call_help", HELPME )
	
function ChangeText()


if CurrentPage == 1 then
pg1:SetText([[ Welcome to Z_Mercs, a gamemode by Wunce.
Press F1 at any time to access this menu. 

The aim of Z_Mercs is to stay alive and complete objectives for money. The long term purpose of the game is to develop the best
mercenary dossier. Your dossier can improve as well as regress so bear that in mind before you go shooting your teammates in the
back.

]])

elseif CurrentPage == 2 then
pg1:SetText([[Menus:
F1 -- Help
F2 -- Team Selection & dossiers
F3 -- Buy Menu
F4 -- Class Special Menu

If you want to have access to the Derma Quick Menu, type in console:
bind h "+shmenu"
Then hold h whenever you want to access this menu.

]])

elseif CurrentPage == 3 then
pg1:SetText([[Buying:
To buy something, press F3, then click on a spawn icon. The tabs across the top grant you access to different types of items.
When you purchase an item, it will be delivered to the buy zone where you can pick it up with your use key.
Don't worry about other teammates stealing your stuff, only you can pick up items unless you check the "Sharing" box in the Derma Quick menu.

Weapon Trivia:
In Z_Mercs, the faster you are travelling, the less accurate your weapons will be, with shotguns being the exception.
Experimental weapons cost more, but are more fun and powerful.
Most weapons have iron-sights when in first person.
You lose all of your items and weapons on death, so don't spend a lot of money if you don't expect to survive.
The catalyst rifle works best when there are too many enemies to kill (fire once, wait for the effect to work its magic)

]])

elseif CurrentPage == 4 then
pg1:SetText([[Co-Ordinator:
Press F4, watch your teammates, warn them of dangers, point them in the direction of objectives and so on.
Hold space to bring up your cursor and click on the drop down menus to select a player to spectate.
Use your movement keys to scroll the top down camera around; sprint speeds this camera up.

The buttons in the bottom right of your screen allow you to perform one of the Co-Ordinators special abilities.
Most are self explanitory however the supply drop may not be as obvious. When you call in the supply drop, 
it becomes the new buy location, allowing mercs to purchase more ammo and weapons mid battle. 
]])
elseif CurrentPage == 5 then
pg1:SetText([[Mercenary:
Kill aliens and complete objectives for cash. Try to build up a positive dossier by regularly completing objectives and
working with your teammates.

Special actions:
Press use on a teammate to heal them. Their most wounded limb is healed first and the other limbs get a little bit of the spray.
If a teammate gets knocked over, press use on them to pick them back up. If they are dead, then you should cry a little over 
their body.

Additional Information:
Healing and helping up teammates will improve your altruism (that's fancy talk for how selfless you are). You can also defeat
enemies that threaten them, be the major risk taker when completing objectives or choose to boot up turrets and towers with
the Identify Friend or Foe system acivated.
]])
elseif CurrentPage == 6 then
pg1:SetText([[Objectives:
Most of the objectives are straight forward. 
- To complete the theives objective, kill them all. You fail if they reach their destination. Taking just one bullet can 
incapacitate even the most hardened of mercs.

- To complete the escort Kleiner objective, press your use key on him to toggle him following or waiting. 
Get him to the buy zone to complete the objective.

- To complete the demolision objective, find the bomb and defuse it. 
To defuse the bomb, get every row and column to equal 10. Be warned, attempting to defuse the bomb will attract the aliens' focus.

Objective markers are blue waypoints which will give you the location of the objective. Note that the bomb is hidden so there is no 
waypoint and the theives is their destination, not their location.
]])
elseif CurrentPage == 7 then
pg1:SetText([[Interest Points:
If you see anything that looks a bit out of the ordinary, press your use key while facing it. You may be surprised at how useful each device is.

- Zombie Beacon: Attracts the horde to you, sparing your teammates.

- Inferno Tower: Gives you the option to turn it on with or without Identify Friendly Foe. 
Read the description provided when you use the device to make an educated decision.

- Gas Canister: If you activate this, a very large area will be covered in a deadly gas. 
Although humans have a resistance to it, it is still fatal after prolonged exposure. Wearing a gasmask makes you immune to the gas.

- AutoTurret: Another device which gives you the option to activate or deactivate IFF.
This beast can shoot down any alien provided it isn't too small.
]]) 
elseif CurrentPage == 8 then
pg1:SetText([[General Help:
If you feel like you are glitched in any way, first make sure you understand some of the features with the game.
- If one of your arms are red, you won't be able to hold any weapons other than pistols.
- If one of your legs are red, you will force crouch and be unable to move.
- If you are ragdolled and are stuck in something when you get up, call an admin to help you out.
- If you are ragdolled and when you get up, your legs are red then you won't be able to move, but you won't crouch.
- Don't fire the catalyst rifle more than once per kill. Let the enemy explode and watch the chain reaction.

If what you are experiencing fit none of the above, contact me through my facepunch account or my steam group Wunce Addons.

]])
end
end
	
	
function AltruisticChoice(um)
ChoiceFrame = vgui.Create( "DFrame" )
ChoiceFrame:SetSize( 400,200 )
ChoiceFrame:Center()
ChoiceFrame:SetTitle( "Activate Device" )
ChoiceFrame:SetVisible( true )
ChoiceFrame:SetDraggable( true )
ChoiceFrame:ShowCloseButton( true )
ChoiceFrame:MakePopup()
ChoiceFrame:SetDraggable( false )
ChoiceFrame.Paint = function() -- Paint function
surface.SetDrawColor( 25, 25, 25, 150 ) 
surface.DrawRect( 0, 0, ChoiceFrame:GetWide(), ChoiceFrame:GetTall() ) 
end

local ChoiceA = vgui.Create( "DButton" )
ChoiceA:SetParent( ChoiceFrame ) 
ChoiceA:SetText( "Activate with IFF" )
ChoiceA:SetPos( 20, 50 )
ChoiceA:SetSize( 200, 20 )
ChoiceA.DoClick = function ()
   RunConsoleCommand("Choice", "A")
   ChoiceFrame:Close()
end
local ChoiceB = vgui.Create( "DButton" )
ChoiceB:SetParent( ChoiceFrame ) 
ChoiceB:SetText( "Activate without IFF" )
ChoiceB:SetPos( 20, 130 )
ChoiceB:SetSize( 200, 20 )
ChoiceB.DoClick = function ()
   RunConsoleCommand("Choice", "B")
   ChoiceFrame:Close()
end
local ChoiceText= vgui.Create("DLabel", ChoiceFrame)
ChoiceText:SetTextColor( Color(255, 255, 255, 255) )
ChoiceText:SetWrap(true)
ChoiceText:SetFont("tablarge")
ChoiceText:SetText(glon.decode(um:ReadString()))
ChoiceText:SetPos( 230, 40) 
ChoiceText:SetSize( 150, 120) 
end	


usermessage.Hook( "call_option", AltruisticChoice )

function BombDefusePuzzle()
local framee = vgui.Create( "DFrame" )
framee:SetSize( 200, 300 )
framee:Center()
framee:SetTitle( "Defusal" )
framee:MakePopup()
/*
succLABEL= vgui.Create("DLabel", framee)
succLABEL:SetTextColor( Color(255, 255, 255, 255) )
succLABEL:SetWrap(true)
succLABEL:SetFont("default")
succLABEL:SetText("Correct Lines: --")
succLABEL:SetPos( 20, 200) 
succLABEL:SetSize( 150, 20) 
*/
 
local grid = vgui.Create( "DGrid", framee )
grid:SetPos( 20, 30 )
grid:SetCols( 4 )
grid:SetColWide( 40 )
but = {}
butcom = {}
for q = 1, 16 do
	but[q] = vgui.Create( "DButton" )
	butcom[q] = math.random(1,4)
	but[q]:SetText(butcom[q])
	but[q]:SetSize( 30, 30 )
	grid:AddItem( but[q] )
	but[q].DoClick = function( )
	if q == 1 or q == 6 or q == 11 or q == 16 then
		but[q]:SetText("-"..butcom[q].."-")
	else
		butcom[q] = butcom[q] + 1
		if butcom[q] == 5 then butcom[q] = 1 end
		but[q]:SetText(butcom[q])
		CheckForSuccess( but )

	end
	
end

end
end
usermessage.Hook( "call_defuse", BombDefusePuzzle )

function CheckForSuccess(but)
succ = 0

for w=0,3 do
total = 0
	for q=((w*4)+1),((w*4)+4) do
	total = butcom[q] + total
	end
if total == 10 then succ = succ + 1 end
end

for w=1,4 do
total = 0
	for q=1,4 do
		total = butcom[q] + total
	end
if total == 10 then succ = succ + 1 end
end
--succLABEL:SetText("Correct Lines: "..succ)
if succ == 8 then RunConsoleCommand("Defuse","2341") end	-- SUCCESSS!!!!
end
