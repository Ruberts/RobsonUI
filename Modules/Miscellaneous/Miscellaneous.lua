local T, C, L = Tukui:unpack()

local Miscellaneous = T["Miscellaneous"]
local Panels = T["Panels"]
local Experience = T.Miscellaneous.Experience
local Ghost = T.Miscellaneous.Ghost
local ObjectiveTracker = T.Miscellaneous.ObjectiveTracker
local AltPowerBar = T.Miscellaneous.AltPowerBar

Experience.NumBars = 1
Experience.RestedColor = {75/255, 175/255, 76/255}
Experience.XPColor = {0/255, 144/255, 255/255}
Experience.AFColor = {229/255, 204/255, 127/255}
Experience.HNColor = {222/255, 22/255, 22/255}

local function CreateButton(self)
	local Button = self.Button
	
	local GhostButton = CreateFrame("Frame", "GhostButton", UIParent)
	GhostButton:SetPoint("TOPLEFT", Minimap, "BOTTOMLEFT", 0, -15)
	GhostButton:Size(Minimap:GetWidth(), 20)
	
	Button:SetAllPoints(GhostButton)
	Button:RobSkin()
	Button:CreateOverlay()
	Button:CreateShadow()
	
	Button.Text:SetFont(C.Medias.Font, 12, "THINOUTLINE")
	Button.Text:SetShadowOffset(0, 0)
end
hooksecurefunc(Ghost, "CreateButton", CreateButton)

local function Enable(self)
	GhostFrame:SetAllPoints(GhostButton)
end
hooksecurefunc(Ghost, "Enable", Enable)

local function Enable(self)
	local ObjectiveTracker = self
	
	ObjectiveTracker:ClearAllPoints()
	ObjectiveTracker:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 20, -25)

end
hooksecurefunc(ObjectiveTracker, "Enable", Enable)

local function CreateAltPowerBar(self)
	local Panels = T.Panels
	local AltPowerBarPanel = Panels.AltPowerBarPanel
	
	self:SetParent(AltPowerBarPanel)
	self:SetAllPoints(AltPowerBarPanel)
	self:SetBackdrop(nil)
	self:HideInsets()
	self:SetFrameStrata(AltPowerBarPanel:GetFrameStrata())
	self:SetFrameLevel(AltPowerBarPanel:GetFrameLevel() + 10)
	
	self.Status:SetInside(AltPowerBarPanel)
	self.Status:RobSkin()
	self.Status:CreateShadow()
	
	self.Status.Text:SetFont(C.Medias.Font, 12, "THINOUTLINE")
	self.Status.Text:SetShadowOffset(0, 0)
	
end
hooksecurefunc(AltPowerBar, "Create", CreateAltPowerBar)

local function SetTooltip(self)
	local XPBar = T.Miscellaneous.Experience.XPBar1

	GameTooltip:ClearAllPoints()
	GameTooltip:SetPoint("TOPRIGHT", XPBar, "BOTTOMRIGHT", 0, -5)
end
hooksecurefunc(Experience, "SetTooltip", SetTooltip)

local function Update(self, event, owner)
	if (event == "UNIT_INVENTORY_CHANGED" and owner ~= "player") then
		return
	end

	local ShowArtifact = HasArtifactEquipped()
	local PlayerLevel = UnitLevel("player")

	local Current, Max = self:GetExperience()
	local Rested = GetXPExhaustion()
	local IsRested = GetRestState()

	for i = 1, self.NumBars do
		local Bar = self["XPBar"..i]
		local RestedBar = self["RestedBar"..i]
		local r, g, b
		
		Bar.BarType = "XP"
		
		if (i == 1 and PlayerLevel == MAX_PLAYER_LEVEL) then
			if ShowArtifact then
				Current, Max = self:GetArtifact()
				Bar.BarType = "ARTIFACT"
			else
				Current, Max = self:GetHonor()
				Bar.BarType = "HONOR"
			end
		elseif (i == 2) then
			if ShowArtifact then
				Current, Max = self:GetArtifact()
				Bar.BarType = "ARTIFACT"
			else
				Current, Max = self:GetHonor()
				Bar.BarType = "HONOR"
			end
		end
		
		local BarType = Bar.BarType
		
		Bar:SetMinMaxValues(0, Max)
		Bar:SetValue(Current)

		if (BarType == "XP" and IsRested == 1 and Rested) then
			RestedBar:Show()
			RestedBar:SetMinMaxValues(0, Max)
			RestedBar:SetValue(Rested + Current)
		else
			RestedBar:Hide()
		end
		
		if BarType == "XP" then
			r, g, b = unpack(self.XPColor)
		elseif BarType == "ARTIFACT" then
			r, g, b = unpack(self.AFColor)
		else
			r, g, b = unpack(self.HNColor)
		end
		Bar:SetStatusBarColor(r, g, b)
	end
end
hooksecurefunc(Experience, "Update", Update)

local function Create(self)
	local XPBar = self.XPBar1
	local RestedBar = self.RestedBar1
	
	XPBar:ClearAllPoints()
	XPBar:SetPoint("TOP", Minimap, "BOTTOM", 0, -5)
	XPBar:Size(Minimap:GetWidth(), 5)
	XPBar.Backdrop:Hide()
	XPBar:RobSkin()
	XPBar:CreateShadow()
	XPBar:SetStatusBarTexture(T.GetTexture(C.UnitFrames.HealthTexture))
end
hooksecurefunc(Experience, "Create", Create)