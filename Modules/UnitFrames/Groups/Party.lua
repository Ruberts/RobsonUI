local T, C, L = Tukui:unpack()

local UnitFrames = T.UnitFrames
local Noop = function() end
local Panels = T["Panels"]

local function Party(self)
	local Health = self.Health
	local Power = self.Power
	local Buffs = self.Buffs
	local Debuffs = self.Debuffs
	local Name = self.Name
	local Leader = self.Leader
	local ReadyCheck = self.ReadyCheck
	local LFDRole = self.LFDRole
	
	self:Size(70, 34)
	
	Buffs:Kill()
	Debuffs:Kill()
	Power:Kill()
	self:SetBackdrop(nil)
	
	Health:Size(70, 34)
	
	Name:ClearAllPoints()
	Name:SetPoint("CENTER", self, "CENTER", 0, 0)
	
	Leader:ClearAllPoints()
	Leader:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
	
	ReadyCheck:ClearAllPoints()
	ReadyCheck:SetPoint("TOPRIGHT", Health, "TOPRIGHT", 0, 0)
	ReadyCheck:Size(10)
	
	LFDRole:ClearAllPoints()
	LFDRole:Size(10)
	LFDRole:Point("BOTTOMRIGHT", 0, 0)
	LFDRole:SetParent(Health)
	LFDRole:SetAlpha(1)
	
	self:Tag(Name, "[Tukui:NameShort][Tukui:Role]")
	--[Tukui:GetNameColor]
end
hooksecurefunc(UnitFrames, "Party", Party)

