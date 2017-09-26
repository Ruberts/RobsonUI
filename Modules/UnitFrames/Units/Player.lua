local T, C, L = Tukui:unpack()

local UnitFrames = T.UnitFrames
local Panels = T["Panels"]
local Noop = function() end

local function Player(self)
	local Panel = self.Panel
	local Health = self.Health
	local Power = self.Power
	local CastBar = self.Castbar
	local Bar4 = T.Panels.ActionBar4
	local Combat = self.Combat
	
	self:SetBackdrop(nil)
	Panel:Kill()

	Health:ClearAllPoints()
	Health:SetPoint("TOPLEFT", self, "TOPLEFT", -1, 1)
	Health:Size(236, 31)
	Health:CreateBorder(false, true)
	Health.colorReaction = false
	Health.colorClass = false
	Health:SetStatusBarColor(0.3, 0.3, 0.3, 1)

	Health.Value:ClearAllPoints()
	Health.Value:SetFontObject(HealthFont)
	Health.Value:Point("LEFT", Health, "BOTTOMLEFT", 8, 0)

	Health.PostUpdate = RobsonUIPostUpdateHealth

	Power:Height(13)
	Power:CreateBorder(false, true)
	--Power.Value:Hide()
	Power.Value:ClearAllPoints()
	Power.Value:SetFontObject(ExpresswayRg)
	Power.Value:Point("RIGHT", Power, "RIGHT", -3, 0)

	Power.colorPower = false
	Power.colorClass = true
	
	Power.PostUpdate = RobsonUIPostUpdatePower

	CastBar:ClearAllPoints()
	CastBar:SetPoint("BOTTOMRIGHT", Bar4, "TOPRIGHT", 0, 5)
	CastBar:Size(Bar4:GetWidth() - 31, 25)
	CastBar:CreateBorder(false, true)
	CastBar:CreateShadow()
	
	CastBar.Button:ClearAllPoints()
	CastBar.Button:Size(25)
	CastBar.Button:SetPoint("RIGHT", CastBar, "LEFT", -6, 0)
	CastBar.Button:SetBackdrop(nil)

	CastBar.Icon:SetAllPoints()
	
	CastBar.Time:ClearAllPoints()
	CastBar.Time:Point("RIGHT", CastBar, "RIGHT", -4, 0)
	
	CastBar.Text:ClearAllPoints()
	CastBar.Text:Point("LEFT", CastBar, "LEFT", 4, 0)
	CastBar.Text:SetWidth(250)
	
	Combat:ClearAllPoints()
	Combat:SetPoint("CENTER", Health, "CENTER", 0, 0)
end
hooksecurefunc(UnitFrames, "Player", Player)

