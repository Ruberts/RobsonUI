local T, C, L = Tukui:unpack()

------------------------------------------------------------------------
-- In my auras edit, I want to move buffs header at top right of the screen
------------------------------------------------------------------------

local Auras = T["Auras"]

local function Skin(self)

	local Count = self.Count
	local Duration = self.Duration
	local Icon = self.Icon
	local Proxy = self.IsProxy
	
	Icon:SetAllPoints()

	self:RobSkin()
	self:CreateShadow()

	Count:SetPoint("TOPRIGHT", self, 1, 1)
	
	if (not Proxy) then
		Duration:ClearAllPoints()
		Duration:SetPoint("BOTTOM", self, 0, -6)
	end


end
hooksecurefunc(Auras, "Skin", Skin)


local function CreateHeaders()
	if (not C.Auras.Enable) then
		return
	end
	
	local Headers = Auras.Headers
	local Buffs = Headers[1]
	local Debuffs = Headers[2]
	
	Buffs:ClearAllPoints()
	Buffs:SetPoint("TOPRIGHT", Minimap, "TOPLEFT", -5, 19)
	
	Debuffs:ClearAllPoints()
	Debuffs:SetPoint("TOPRIGHT", Minimap, "BOTTOMLEFT", -5, 30)
end
hooksecurefunc(Auras, "CreateHeaders", CreateHeaders)
