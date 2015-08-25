AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" ) 
include('shared.lua')

function ENT:Initialize()
	self:SetModel("models/props_lab/blastdoor001c.mdl")
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:DrawShadow(false)
	/*
	timer.Simple(0,function()
		self:SetDTEntity(0, self.attachedplayer)
	end)
	*/
	 local effectdata = EffectData()
	effectdata:SetOrigin(self.endpos)
	effectdata:SetStart(self.startpos)
	effectdata:SetScale(1)

	util.Effect("laser", effectdata)
	timer.Simple(1.5,function()
		self.Remove()
	end)
end


 
function ENT:Use( activator, caller )

	end



function ENT:SpawnFunction(ply, trace)

end
