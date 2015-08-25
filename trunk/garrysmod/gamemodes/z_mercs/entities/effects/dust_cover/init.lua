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
	self.Position = data:GetOrigin()+Vector(0,0,1000)
	
	self.RightAngle = self.Normal:Angle():Right():Angle()

	self.KillTime = CurTime() + 5


	local emitter = ParticleEmitter(self.Position)
		for k=1,20 do

			for q=1,20 do
			
			local trace = {}
	trace.start = self.Position + Vector((10-k)*150,(10-q)*100,0)
	trace.endpos = self.Position + Vector((10-k)*150,(10-q)*100,-5000)
	trace.mask = MASK_SOLID_BRUSHONLY
			local tracey = util.TraceLine(trace)
	
			local spot = tracey.HitPos
			local fract = tracey.Fraction

			
			local dietime = math.random(100,120)
			local sizee = math.random(50,100)
			
			local particle = emitter:Add("particles/smokey",  spot+Vector(0,0,math.random(math.Round(sizee*0.5),math.Round(sizee*1.5)) ))
			
			particle:SetVelocity(Vector(0,0,0))
			particle:SetGravity(Vector(math.Rand(-5,5),math.Rand(-5,5),0))
			
			particle:SetAirResistance(50)
			particle:SetDieTime(dietime)
			particle:SetLifeTime(math.Rand(-0.12,-0.08))
			particle:SetStartAlpha(60)
			particle:SetEndAlpha(40)
			particle:SetThinkFunction(SmokeParticleUpdate)
			particle:SetNextThink(CurTime() + 0.5*dietime)
			
			
			particle:SetStartSize(sizee)
			particle:SetEndSize(sizee)
			particle:SetRoll(math.Rand(0,360))
			particle:SetRollDelta(math.Rand(-0.3,0.3))
			particle:SetColor(207,199,149)
			
			end
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





