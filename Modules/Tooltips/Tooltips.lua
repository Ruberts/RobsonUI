local T, C, L = Tukui:unpack()

local Tooltip = T["Tooltips"]

local HealthBar = GameTooltipStatusBar

local function CreateAnchor(self)
	local Anchor = self.Anchor
	
	Anchor:ClearAllPoints()
	Anchor:SetPoint("BOTTOMRIGHT", UIParent, -10, 200)

end
hooksecurefunc(Tooltip, "CreateAnchor", CreateAnchor)

local function Skin(self)

	self:RobSkin()
	--self:CreateShadow()

end
hooksecurefunc(Tooltip, "Skin", Skin)

local function Enable(self)
	
	HealthBar:RobSkin()
	HealthBar.Backdrop:Hide()
	HealthBar:Point("BOTTOMLEFT", HealthBar:GetParent(), "TOPLEFT", 0, 0)
	HealthBar:Point("BOTTOMRIGHT", HealthBar:GetParent(), "TOPRIGHT", 0, 0)	
	
end
hooksecurefunc(Tooltip, "Enable", Enable)