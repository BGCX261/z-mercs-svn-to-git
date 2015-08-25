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

	self.Normal = data:GetNormal()
	self.Position = data:GetOrigin()
	self.Start = data:GetStart()
	
	self.RightAngle = self.Normal:Angle():Right():Angle()

	self.KillTime = CurTime() + 5


	local emitter = ParticleEmitter(self.Position)
		for i=1,5 do

			local vecang = self.RightAngle
			vecang:RotateAroundAxis(self.Normal,math.Rand(0,360))
			vecang = vecang:Up() + VectorRand()*0.1
			local velocity = math.Rand(5,35)*self.Normal
			local particle = emitter:Add("zmercs/particles/wunce_particle_fire2",  self.Position + self.Normal * math.Rand(0,16))
			local dietime = math.Rand(3,5)
			
			particle:SetVelocity(velocity)
			particle:SetGravity(Vector(math.Rand(-1,1),math.Rand(-1,1),math.Rand(3,5)))
			
			particle:SetAirResistance(50)
			particle:SetDieTime(dietime)
			particle:SetLifeTime(math.Rand(-0.12,-0.08))
			particle:SetStartAlpha(200)
			particle:SetEndAlpha(0)
			particle:SetThinkFunction(SmokeParticleUpdate)
			particle:SetNextThink(CurTime() + 0.5*dietime)
			particle:SetStartSize(10)
			particle:SetEndSize(10)
			particle:SetRoll(math.Rand(5,15))
			particle:SetRollDelta(0.2*math.random(-1,1))

			particle:SetColor(200,200,200)
		end

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

