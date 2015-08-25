EFFECT.Mat = Material( "sprites/bluelaser1" )

/*---------------------------------------------------------
   Init( data table )
---------------------------------------------------------*/
function EFFECT:Init( data )

    self.StartPos     = data:GetStart()    
    self.EndPos     = data:GetOrigin()
	self.ply = data:GetEntity()
    
    print(self.ply:Nick().." has the laser enabled.")
    self:SetRenderBoundsWS( self.StartPos, self.EndPos )
    
    
end

/*---------------------------------------------------------
   THINK
---------------------------------------------------------*/
function EFFECT:Think( )
trace = util.GetPlayerTrace( self.ply)
traceRes=util.TraceLine(trace)
self.StartPos = GetOurAttachment(self.ply).Pos + GetOurAttachment(self.ply).Ang:Right() * 2
self.StartPosB = GetOurOtherAttachment(self.ply).Pos + GetOurOtherAttachment(self.ply).Ang:Up() * 10 + GetOurOtherAttachment(self.ply).Ang:Right() * 3
self.EndPos = traceRes.HitPos
self:SetRenderBoundsWS( self.StartPos, self.EndPos )
self.randytrans = math.Rand(0.5,1.5)

	if self.ply:Alive() then
		return true
	else
		return false
	end
end

function GetOurAttachment(ply)
local ID = ply:LookupAttachment("eyes") 
return ply:GetAttachment( ID ) 
end

function GetOurOtherAttachment(ply)
local ID = ply:LookupAttachment("anim_attachment_RH") 
return ply:GetAttachment( ID ) 
end
/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
	surface.CreateFont ( "coolvetica", 4, 300, true, false, "CV4", false)
function EFFECT:Render( )

 // AMMO COUNTER DRAW //
	if !self.ply:Alive() then return end
 

	local ang = self.ply:EyeAngles()
	local pos = self.StartPosB
 
	ang:RotateAroundAxis( ang:Forward(), 90 )
	ang:RotateAroundAxis( ang:Right(), 90 )
	
	if self.ply:GetActiveWeapon():IsValid() and self.ply:GetActiveWeapon():GetClass() != "catalyst_rifle" and self.ply:GetActiveWeapon():GetClass() != "recharge_pistol" and LocalPlayer() == self.ply then
	cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 0.15 )
	draw.DrawText( self.ply:GetActiveWeapon():Clip1(), "CV20", 2, 2, Color( 150, 255, 150, 255 ), TEXT_ALIGN_CENTER )
	cam.End3D2D()
	end
	
	
	if self.ply:GetActiveWeapon():IsValid() and LasClip[self.ply:UserID()] and LasClip[self.ply:UserID()] != -1 and LocalPlayer() != self.ply then
	cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 0.15 )
	draw.DrawText( LasClip[self.ply:UserID()], "CV20", 2, 2, Color( 150, 255, 150, 255 ), TEXT_ALIGN_CENTER )
	cam.End3D2D()
	end
	
    render.SetMaterial(self.Mat)
    render.DrawBeam( self.StartPos,         
                     self.EndPos,
                     1,                    
                     0,                    
                     0,                
                     Color( 0, 255, 0, 100 + (50 * self.randytrans ) ) )
                     
end