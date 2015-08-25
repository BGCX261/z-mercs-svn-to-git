AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" ) 
include('shared.lua')

function ENT:Initialize()
	self:SetModel("models/props/kb_mouse/mouse.mdl")
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:DrawShadow(false)
	--self:SetParent(self.attachedplayer)
	/*
	self:SetLocalPos(GetOurAttachment(self.attachedplayer).Pos + GetOurAttachment(self.attachedplayer).Ang:Right() * 5 - self:GetPos() )
	self:SetAngles(Angle(90,GetOurAttachment(self.attachedplayer).Ang.y,90))
	*/
	 local effectdata = EffectData()
	effectdata:SetOrigin(self.attachedplayer:GetAimVector())
	effectdata:SetNormal(self.attachedplayer:GetPos())
	effectdata:SetScale(1)
	effectdata:SetEntity(self.attachedplayer)
	util.Effect("laser", effectdata)
end
/*
 function ENT:SetupDataTables()
 
    self:DTVar( "Entity", 0, "player" )
 end
*/
 function ENT:Think()
if !self.attachedplayer:Alive() then
self:Remove()
end

 end
 
 function GetOurAttachment(ply)
local ID = ply:LookupAttachment("eyes") 
return ply:GetAttachment( ID ) 
end

 
function ENT:Use( activator, caller )

	end



function ENT:SpawnFunction(ply, trace)

end
