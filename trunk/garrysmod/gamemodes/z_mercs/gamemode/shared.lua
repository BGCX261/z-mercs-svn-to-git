

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

// BASIC HUD //
resource.AddFile( "materials/zmercs/BODY.vtf")
resource.AddFile( "materials/zmercs/BODY.vmt")
resource.AddFile( "materials/zmercs/HEAD.vtf")
resource.AddFile( "materials/zmercs/HEAD.vmt")
resource.AddFile( "materials/zmercs/LARM.vtf")
resource.AddFile( "materials/zmercs/LARM.vmt")
resource.AddFile( "materials/zmercs/RARM.vtf")
resource.AddFile( "materials/zmercs/RARM.vmt")
resource.AddFile( "materials/zmercs/LLEG.vtf")
resource.AddFile( "materials/zmercs/LLEG.vmt")
resource.AddFile( "materials/zmercs/RLEG.vtf")
resource.AddFile( "materials/zmercs/RLEG.vmt")
resource.AddFile( "materials/zmercs/SHIELD.vtf")
resource.AddFile( "materials/zmercs/SHIELD.vmt")
resource.AddFile( "materials/zmercs/objectivebanner.vtf")
resource.AddFile( "materials/zmercs/objectivebanner.vmt")
resource.AddFile( "materials/zmercs/zmercwaypoint2.vtf")
resource.AddFile( "materials/zmercs/zmercwaypoint2.vmt")
resource.AddFile( "materials/zmercs/redring.vtf")
resource.AddFile( "materials/zmercs/redring.vmt")
resource.AddFile( "materials/zmercs/veins.vtf")
resource.AddFile( "materials/zmercs/veins.vmt")

// BACKGROUNDS //
resource.AddFile( "materials/zmercs/help.vtf")
resource.AddFile( "materials/zmercs/help.vmt")
resource.AddFile( "materials/zmercs/background.vtf")
resource.AddFile( "materials/zmercs/background.vmt")
resource.AddFile( "materials/zmercs/buymenu.vtf")
resource.AddFile( "materials/zmercs/buymenu.vmt")
resource.AddFile( "materials/zmercs/scoreboard.vtf")
resource.AddFile( "materials/zmercs/scoreboard.vmt")
resource.AddFile( "materials/zmercs/staticeffect.vtf")
resource.AddFile( "materials/zmercs/staticeffect.vmt")

// CROSSHAIRS //
resource.AddFile( "materials/zmercs/crosshaircross.vtf")
resource.AddFile( "materials/zmercs/crosshaircross.vmt")
resource.AddFile( "materials/zmercs/crosshairsquare.vtf")
resource.AddFile( "materials/zmercs/crosshairsquare.vmt")
resource.AddFile( "materials/zmercs/crosshairline.vtf")
resource.AddFile( "materials/zmercs/crosshairline.vmt")
resource.AddFile( "materials/zmercs/crosshairtriangle.vtf")
resource.AddFile( "materials/zmercs/crosshairtriangle.vmt")
resource.AddFile( "materials/zmercs/crosshaircircle.vtf")
resource.AddFile( "materials/zmercs/crosshaircircle.vmt")

// PARTICLES //
resource.AddFile( "materials/zmercs/particles/wunce_particle_fire.vtf")
resource.AddFile( "materials/zmercs/particles/wunce_particle_fire.vmt")
resource.AddFile( "materials/zmercs/particles/wunce_particle_fire2.vtf")
resource.AddFile( "materials/zmercs/particles/wunce_particle_fire2.vmt")
resource.AddFile( "materials/zmercs/particles/wunce_particle_trismoke.vtf")
resource.AddFile( "materials/zmercs/particles/wunce_particle_trismoke.vmt")


GM.Name 	= "Z_Mercs"
GM.Author 	= "Wunce"
GM.Email 	= "N/A"
GM.Website 	= "N/A"

function GM:CreateTeams()

team.SetUp( 2, "Merc", Color( 50, 255, 50, 255 ) ) 
team.SetUp( 3, "Survivor", Color( 200, 200, 0, 255 ) )-- maybe I should actually make another team....
team.SetUp( 1, "Co-Ordinator", Color( 0, 100, 255, 255 ) )
end

