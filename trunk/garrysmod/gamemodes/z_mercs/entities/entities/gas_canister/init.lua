AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" ) 
include('shared.lua')

util.PrecacheSound("weapons/mortar/mortar_shell_incomming1.wav") 
function ENT:Initialize()
	self:SetModel( "models/props_borealis/bluebarrel001.mdl") 
	self:PhysicsInit( SOLID_VPHYSICS )      
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )   
	
	
	self:SetUseType(SIMPLE_USE)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
       local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end

end

GasOrigin = Vector(0,0,0)
goodoldloops = 0
			gasdamage = DamageInfo()
			gasdamage:SetDamageType( DMG_NERVEGAS ) 
			gasdamage:SetDamageForce( Vector( 0, 0, 0 ) ) 
			

function ENT:Use( activator, caller )
local phys = self:GetPhysicsObject()
if phys:IsValid() then
	phys:AddVelocity( Vector(0, 0, 3500) )
end

local gooddeed = true
	for k, ply in pairs(player.GetAll()) do
		if ply.GasMask == false then
			gooddeed = false
		end
	end

	if gooddeed == false then
	AltDown(activator, activator.Altruism ,8)
	end

self:EmitSound("weapons/mortar/mortar_shell_incomming1.wav")

	timer.Simple(3,function()
	GasOrigin = self:GetPos()
	
							local gasbomb = ents.Create("gas_effect")

							gasbomb:SetPos(GasOrigin)
							gasbomb:SetVar("Owner",self)
							gasbomb:SetVar("Scale",5)
							gasbomb:SetAngles(self:GetAngles())
							gasbomb:Spawn()
							
	
		timer.Create("GAS",5,0,function()
		goodoldloops = goodoldloops + 5
			for k, ent in pairs(ents.FindInSphere(GasOrigin,5000)) do
			
				if ent:IsPlayer() and !ent.GasMask and ent.optin then
					gasdamage:SetAttacker( activator )
					gasdamage:SetInflictor(  self )
					gasdamage:SetDamage( 5 )
					ent.hitgroups[HITGROUP_HEAD] = ent.hitgroups[HITGROUP_HEAD] - 2
					ent:TakeDamageInfo( gasdamage ) 
					headandbodydamage(ent, ent.hitgroups[HITGROUP_HEAD], ent.hitgroups[HITGROUP_CHEST])
					
				elseif ent:IsNPC() then
					gasdamage:SetDamage( 15 )
					gasdamage:SetAttacker( activator )
					gasdamage:SetInflictor(  self )					
					ent:TakeDamageInfo( gasdamage )
				end
			end
			
			if goodoldloops > 120 then 
			timer.Stop("GAS")
			self:Remove()
			end
		end)
		
		self:SetColor(255,255,255,0)
	end)
end

function ENT:Think()

end

function ENT:SpawnFunction(ply, trace)
	if (not trace.Hit) then return end
	local entt = ents.Create("demo_charge");
	if entt != NULL then
	entt:SetPos(trace.HitPos + trace.HitNormal * 16) --ent is returning NULL
	entt:Spawn()
	entt:Activate()
	else
	ply:ChatPrint("fuuuuuuuuuuu")
	return entt
	end
end
