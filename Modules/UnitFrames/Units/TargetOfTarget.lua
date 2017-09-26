local T, C, L = Tukui:unpack()

local UnitFrames = T.UnitFrames

local function TargetOfTarget(self)
	local Panel = self.Panel
	local Health = self.Health
	local Name = self.Name
	
	Panel:Kill()
	self:SetBackdrop(nil)
	
	Health:ClearAllPoints()
	Health:SetPoint("TOP", self, "TOP", 0, 0)
	Health:Size(100, 22)
	Health:CreateBorder(false, true)
	
	Health.Background:SetColorTexture(0.1, 0.1, 0.1)
	
	Name:SetParent(Health)
	Name:SetPoint("CENTER", Health, "CENTER", 0, 0)
	self:Tag(Name, "[Tukui:NameShort]")
end
hooksecurefunc(UnitFrames, "TargetOfTarget", TargetOfTarget)

-- Fixa backdropen likt Player och target
