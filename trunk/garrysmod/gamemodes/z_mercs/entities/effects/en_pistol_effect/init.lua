EFFECT.Mat = Material( "sprites/bluelaser1" )

local SmokeParticleUpdate = function(particle)

	if particle:GetStartAlpha() == 0 and particle:GetLifeTime() >= 0.5*particle:GetDieTime() then
		particle:SetStartAlpha(particle:GetEndAlpha())
		particle:SetEndAlpha(0)
		particle:SetNextThink(-1)
	else
		particle:SetNextThink(CurTime() + 0.1)
	end

	return particle

end

/*---------------------------------------------------------
   Init( data table )
---------------------------------------------------------*/
function EFFECT:Init( data )

    self.StartPos     = data:GetStart()    
    self.EndPos     = data:GetOrigin()
	
	self.ColourR = data:GetNormal().x
	self.ColourG = data:GetNormal().y
	self.ColourB = data:GetNormal().z
	
    self.Dir         = self.EndPos - self.StartPos
    self.trans		= 200
    self:SetRenderBoundsWS( self.StartPos, self.EndPos )
    self.fadeout = CurTime() + 0.25

    
    // Die when it reaches its target
    
    
end

/*---------------------------------------------------------
   THINK
---------------------------------------------------------*/
function EFFECT:Think( )
local timerythingy = self.fadeout - CurTime()
self.trans = timerythingy * 800
self.size = (timerythingy * -12) + 4
if timerythingy <= 0 then return false
else return true
end
end

/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render( )

    render.SetMaterial(self.Mat)
    render.DrawBeam( self.StartPos,         
                     self.EndPos,
                     self.size,                    
                     0,                    
                     0,                
                     Color( self.ColourR, self.ColourG, self.ColourB, self.trans ))
                     --75, 150, 230
end
