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

	self.Colour = data:GetScale()
	self.Normal = data:GetNormal()
	self.Position = data:GetOrigin() - 12*self.Normal
	
	self.RightAngle = self.Normal:Angle():Right():Angle()

	self.KillTime = CurTime() + 5


	local emitter = ParticleEmitter(self.Position)
		for i=1,math.ceil(12) do

			local vecang = self.RightAngle
			vecang:RotateAroundAxis(self.Normal,math.Rand(0,360))
			vecang = vecang:Up() + VectorRand()*0.1
			local velocity = math.Rand(50,200)*vecang
			local particle = emitter:Add("particles/smokey",  self.Position - vecang*32 + self.Normal*math.Rand(0,64))
			local dietime = math.Rand(10,12)
			
			particle:SetVelocity(velocity)
			particle:SetGravity(Vector(math.Rand(-15,15),math.Rand(-15,15),math.Rand(-15,-5)))
			
			particle:SetAirResistance(50)
			particle:SetDieTime(dietime)
			particle:SetLifeTime(math.Rand(-0.12,-0.08))
			particle:SetStartAlpha(200)
			particle:SetEndAlpha(0)
			particle:SetThinkFunction(SmokeParticleUpdate)
			particle:SetNextThink(CurTime() + 0.5*dietime)
			particle:SetStartSize(75)
			particle:SetEndSize(75)
			particle:SetRoll(math.Rand(20,50))
			particle:SetRollDelta(0.6*math.random(-1,1))
			if self.Colour == 2 then
			particle:SetColor(150,50,50)
			else
			particle:SetColor(207,199,149)
			end
		end
self.Entity:EmitSound("weapons/explode3.wav")
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





