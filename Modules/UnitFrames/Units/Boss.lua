local T, C, L = Tukui:unpack()

local UnitFrames = T.UnitFrames
local Noop = function() end
local Panels = T["Panels"]

local function Boss(self)
	--local Panel = self.Panel
	local Health = self.Health
	local Power = self.Power
	local Name = self.Name
	local CastBar = self.Castbar
	local Buffs = self.Buffs
	local Debuffs = self.Debuffs
	
	self:SetBackdrop(nil)
	--Panel:Kill()


	--Health:ClearAllPoints()
	--Health:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
	Health:Height(25)
	Health:CreateBorder(false, true)

	Health.Value:ClearAllPoints()
	Health.Value:SetFontObject(HealthFont)
	Health.Value:Point("RIGHT", Health, "BOTTOMRIGHT", -8, 0)
	
	Health.Percent = Health:CreateFontString(nil, "OVERLAY")
	Health.Percent:SetFontObject(ExpresswayRg)
	Health.Percent:Point("LEFT", Power, "LEFT", 3, 0)
	
	self:Tag(Health.Percent, "[perhp]%")
	Health.PostUpdate = RobsonUIPostUpdateHealth
	
	Power:Height(13)
	Power:CreateBorder(false, true)
	
	Name:ClearAllPoints()
	Name:SetPoint("LEFT", Health, "LEFT", 3, 0)
	
	self:Tag(Name, "[Tukui:NameLong] [Tukui:DiffColor][level] [shortclassification]")
	
	if (C.UnitFrames.BossAuras) then
		Buffs:SetHeight(16)
		Buffs:SetWidth(252)
		Buffs:Point("TOPRIGHT", self, "TOPLEFT", -4, 0)
		Buffs.size = 16
		Buffs.num = 5
		Buffs.spacing = 4
		Buffs.initialAnchor = "RIGHT"
		Buffs["growth-x"] = "LEFT"
		--Buffs.PostCreateIcon = TukuiUnitFrames.PostCreateAura
		--Buffs.PostUpdateIcon = TukuiUnitFrames.PostUpdateAura

		Debuffs:SetHeight(16)
		Debuffs:SetWidth(252)
		Debuffs:Point("BOTTOMRIGHT", self, "BOTTOMLEFT", -20, 0)
		Debuffs.size = 16
		Debuffs.num = 5
		Debuffs.spacing = 4
		Debuffs.initialAnchor = "LEFT"
		Debuffs["growth-x"] = "LEFT"
		--Debuffs.PostCreateIcon = TukuiUnitFrames.PostCreateAura
		--Debuffs.PostUpdateIcon = TukuiUnitFrames.PostUpdateAura
	end
	

end
hooksecurefunc(UnitFrames, "Boss", Boss)

