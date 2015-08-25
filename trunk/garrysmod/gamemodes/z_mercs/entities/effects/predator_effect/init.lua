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


function EFFECT:Init(data)
	self.Scale = data:GetScale()
	self.Normal = data:GetNormal()
	self.Position = data:GetOrigin() 
	self.KillTime = 1
	
			local emitter = ParticleEmitter(self.Position)
			local particle = emitter:Add("zmercs/particles/wunce_particle_trismoke",  self.Position)

			particle:SetVelocity(Vector(0,0,0))
			particle:SetGravity(Vector(0,0,0))
			
			particle:SetAirResistance(50)
			particle:SetDieTime(1)
			particle:SetLifeTime(math.Rand(-0.12,-0.08))
			particle:SetStartAlpha(200)
			particle:SetEndAlpha(0)
			particle:SetThinkFunction(SmokeParticleUpdate)
			particle:SetNextThink(0.1)
			particle:SetStartSize(5)
			particle:SetEndSize(5)
			particle:SetRoll(math.Rand(0,0))
			particle:SetRollDelta(0)
			particle:SetColor(200,255,200)



emitter:Finish()
	
end


--THINK
-- Returning false makes the entity die
function EFFECT:Think()
	local TimeLeft = self.KillTime - CurTime()
	if TimeLeft > 0 then 
		return true
	else
		return false	
	end
end


-- Draw the effect
function EFFECT:Render()


end





