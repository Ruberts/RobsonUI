local T, C, L = Tukui:unpack()

local UnitFrames = T.UnitFrames
local Noop = function() end
local Panels = T["Panels"]

local function Raid(self)
	local Health = self.Health
	local Power = self.Power
	local Panel = self.Panel
	local Name = self.Name
	local ReadyCheck = self.ReadyCheck
	local LFDRole = self.LFDRole
	
	self:SetBackdrop(nil)
	
	Health:Size(74, 32)
	Health:CreateBorder(false, true)
	
	Power:Kill()
	
	Panel:ClearAllPoints()
	Panel:Point("TOPLEFT", Health, "BOTTOMLEFT", 0, 0)
	Panel:Point("TOPRIGHT", Health, "BOTTOMRIGHT", 0, 0)
	
	Name:ClearAllPoints()
	Name:SetPoint("CENTER", Health, "CENTER", 0, 0)
	
	ReadyCheck:ClearAllPoints()
	ReadyCheck:SetPoint("TOPRIGHT", Health, "TOPRIGHT", 0, 0)
	
	LFDRole:ClearAllPoints()
	LFDRole:Size(10)
	LFDRole:Point("BOTTOMRIGHT", 0, 0)
	LFDRole:SetParent(Health)
	LFDRole:SetAlpha(1)
	
	self:Tag(Name, "[Tukui:NameShort]")
	--[Tukui:GetNameColor]
	--[Tukui:Role]
end
hooksecurefunc(UnitFrames, "Raid", Raid)

