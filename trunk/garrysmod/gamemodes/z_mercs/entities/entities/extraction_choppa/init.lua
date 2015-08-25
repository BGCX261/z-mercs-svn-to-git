AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" ) 
include('shared.lua')

--util.PrecacheSound("weapons/mortar/mortar_shell_incomming1.wav") 
function ENT:Initialize()
	self:SetModel( "models/props_phx/construct/metal_plate4x4.mdl") -- CHANGE THIS TO A PHX PLATE
	self:PhysicsInit( SOLID_VPHYSICS )      
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )   
	
	self:StartMotionController()

	self:SetUseType(SIMPLE_USE)

       self.phys = self:GetPhysicsObject()
	if (self.phys:IsValid()) then
		self.phys:Wake()
	end
		timer.Simple(0.1,function()
		self.phys:EnableMotion(false)
		end)
end

concommand.Add("PELICANTEST", function (ply, c, a)

local entt = ents.Create("extraction_choppa");
	entt:SetPos(ply:GetPos()) --ent is returning NULL
	entt:SetAngles(ply:GetAngles())
	entt:Spawn()
	entt:Activate()

end)

function ENT:Think()
	if self.move and self.move <= CurTime() then
		self:SetPos( self:GetPos() + ZOPS[2]:Normalize())
		self.move = CurTime() + 0.05
	end
end
/*
function ENT:PhysicsSimulate( phys, deltatime )
 
	if (!self.IsOn) then return SIM_NOTHING end
 
	local ForceAngle, ForceLinear = Vector(0,0,0), self.ForceLinear
 
	return ForceAngle, ForceLinear, SIM_LOCAL_ACCELERATION
 
end
*/
function ENT:SpawnFunction(ply, trace)
	if (not trace.Hit) then return end
	local entt = ents.Create("extraction_choppa");
	if entt != NULL then
	entt:SetPos(ply:GetPos()) --ent is returning NULL
	entt:Spawn()
	entt:Activate()
	else
	ply:ChatPrint("fuuuuuuuuuuu")
	return entt
	end
end
