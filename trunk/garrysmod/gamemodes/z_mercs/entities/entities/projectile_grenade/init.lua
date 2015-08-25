AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" ) 
include('shared.lua')


function ENT:Initialize()
	self:SetModel( "models/Items/AR2_Grenade.mdl") -- CHANGE THIS
	self:PhysicsInit( SOLID_VPHYSICS )      
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )   
	
	
	self:SetUseType(SIMPLE_USE)
       local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end

end

function sharpenel(ent, dir)

	bullet = {}
bullet.Num=50
bullet.Src=ent:GetPos()
bullet.Dir=dir:Forward()
bullet.Spread=Vector(2,2,0)
bullet.Tracer=1	
bullet.Force=5
bullet.Damage=10
ent:FireBullets(bullet)
end

function ENT:PhysicsCollide( data, physobj )
/*
 	local explodee = ents.Create("env_explosion")
	--print(data.Speed)		
	explodee:SetPos(self:GetPos())
		explodee:Spawn() 
	explodee:SetKeyValue("iMagnitude","100") 
		explodee:Fire("Explode", 0, 0 ) 
	explodee:EmitSound("weapon_AWP.Single", 400, 400 ) --different sound here
*/
							local gasbomb = ents.Create("dusty_explosion")
							gasbomb:SetPos(self:GetPos())
							gasbomb:SetVar("Owner",self.Owner)
							gasbomb:SetVar("Scale",self.red)
							gasbomb:SetAngles(self:GetAngles())
							gasbomb:Spawn()

							
	
-- if these aren't working consider an alternative
 sharpenel(self,(-data.HitNormal):Angle())
	
	self:Remove()
-- end
end
