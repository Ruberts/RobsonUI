local T, C, L = Tukui:unpack()

local UnitFrames = T.UnitFrames
local Noop = function() end
local Panels = T["Panels"]

local function Target(self)
	local Panel = self.Panel
	local Health = self.Health
	local Power = self.Power
	local Name = self.Name
	local CastBar = self.Castbar
	local Buffs = self.Buffs
	local Debuffs = self.Debuffs
	
	self:SetBackdrop(nil)
	Panel:Kill()

	Health:ClearAllPoints()
	Health:SetPoint("TOPLEFT", self, "TOPLEFT", -1, 1)
	Health:Size(236, 31)
	Health:CreateBorder(false, true)

	Health.Value:ClearAllPoints()
	Health.Value:SetFontObject(HealthFont)
	Health.Value:Point("RIGHT", Health, "BOTTOMRIGHT", -8, 0)
	
	Health.Percent = Health:CreateFontString(nil, "OVERLAY")
	Health.Percent:SetFontObject(ExpresswayRg)
	Health.Percent:Point("LEFT", Power, "LEFT", 3, 0)
	
	-- Health:SetScript("OnValueChanged", function(self, health)
		-- local _, maxHealth = self:GetMinMaxValues();
		-- Health.Percent:SetFormattedText("%.1f%%", (health / maxHealth) * 100);
	-- end)
	
	self:Tag(Health.Percent, "[perhp]%")
	
	Health.colorTapping = false
	Health.colorClass = false
	Health.colorReaction = false	
	Health:SetStatusBarColor(0.3, 0.3, 0.3, 1)	


	Health.PreUpdate = RobsonUIPreUpdateHealth
	Health.PostUpdate = RobsonUIPostUpdateHealth

	Power:Height(13)
	Power:CreateBorder(false, true)
	Power.Value:Hide()
	
	Power.colorPower = false
	Power.colorClass = true
	Power.colorClassNPC = true
	
	Name:SetParent(Health)
	
	CastBar:ClearAllPoints()
	CastBar:SetPoint("BOTTOM", Health, "TOP", 0, 150)
	CastBar:Size(Health:GetWidth(), 20)
	CastBar:CreateBorder(false, true)
	CastBar:CreateShadow()

	CastBar.Button:ClearAllPoints()
	CastBar.Button:Size(25)
	CastBar.Button:SetPoint("BOTTOM", CastBar, "TOP", 0, 5)
	CastBar.Button:SetBackdrop(nil)

	CastBar.Icon:SetAllPoints()
	
	CastBar.Time:ClearAllPoints()
	CastBar.Time:Point("RIGHT", CastBar, "RIGHT", -4, 0)
	
	CastBar.Text:ClearAllPoints()
	CastBar.Text:Point("LEFT", CastBar, "LEFT", 4, 0)
	
	Buffs:SetHeight(26)
	Buffs:SetWidth(236)
	Buffs.size = 26
	Buffs.num = 24
	Buffs.numRow = 8
	Buffs.spacing = 4
	
	Debuffs:ClearAllPoints()
	Debuffs:SetHeight(26)
	Debuffs:SetWidth(236)
	Debuffs.size = 26
	Debuffs.num = 24
	Debuffs.numRow = 8
	Debuffs.spacing = 4
end
hooksecurefunc(UnitFrames, "Target", Target)
