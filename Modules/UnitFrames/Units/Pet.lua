local T, C, L = Tukui:unpack()

local UnitFrames = T.UnitFrames

local function Pet(self)
	local Panel = self.Panel
	local Health = self.Health
	local Power = self.Power
	local Name = self.Name
	
	Panel:Kill()
	Power:Kill()
	self:SetBackdrop(nil)
	
	Health:ClearAllPoints()
	Health:SetPoint("TOP", self, "TOP", 0, 0)
	Health:Size(100, 22)
	
	Health.colorReaction = false
	Health:SetStatusBarColor(0.3, 0.3, 0.3, 1)
	
	Name:SetParent(Health)
	Name:SetPoint("CENTER", Health, "CENTER", 0, 0)
	self:Tag(Name, "[Tukui:NameShort]")
	

end
hooksecurefunc(UnitFrames, "Pet", Pet)

