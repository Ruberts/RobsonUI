local T, C, L = Tukui:unpack()

local Maps = T.Maps
local Minimap = T.Maps.Minimap
local Panels = T.Panels

local function StyleMinimap(self)
	local Mail = MiniMapMailFrame
	self.Backdrop:Hide()
	self:RobSkin()
	
	Mail:Point("TOPRIGHT", self, "TOPRIGHT", 5, 5)
end
hooksecurefunc(Minimap, "StyleMinimap", StyleMinimap)

local function AddZoneAndCoords(self)
	local MinimapZone = TukuiMinimapZone
	local MinimapCoords = TukuiMinimapCoord
	
	MinimapZone:Size(self:GetWidth(), 19)
	MinimapZone:Point("TOP", self, 0, 19)
	MinimapZone:CreateOverlay()
	MinimapZone:RobSkin()
	MinimapZone:SetAlpha(1)
	MinimapZone.Text:SetFont(C["Medias"].Font, 12, "OUTLINE")
	MinimapZone.overlay:SetVertexColor(0.2, 0.2, 0.2)
	
	MinimapCoords:CreateOverlay()
	MinimapCoords:RobSkin()
	MinimapCoords.Text:Point("CENTER", 0, 0)
end
hooksecurefunc(Minimap, "AddZoneAndCoords", AddZoneAndCoords)

local function PositionMinimap(self)
	self:Point("TOPRIGHT", UIParent, "TOPRIGHT", -10, -29)
end
hooksecurefunc(Minimap, "PositionMinimap", PositionMinimap)

local function AddMinimapDataTexts(self)
	local MinimapDataTextOne = Panels.MinimapDataTextOne
	local MinimapDataTextTwo = Panels.MinimapDataTextTwo
	
	MinimapDataTextOne:Hide()
	
	MinimapDataTextTwo:ClearAllPoints()
	MinimapDataTextTwo:SetPoint("CENTER", self, "BOTTOM", 0, 8)
	MinimapDataTextTwo:Size(50, 13)
	-- Ugly way of removing backdrop panel...
	MinimapDataTextTwo:HideInsets()
	MinimapDataTextTwo:SetBackdrop(nil)
end
hooksecurefunc(Minimap, "AddMinimapDataTexts", AddMinimapDataTexts)

local function EnableMouseOver(self)
	self:SetScript("OnEnter", function()
		Minimap.MinimapZone:SetAlpha(1)
		Minimap.MinimapCoords:SetAlpha(1)
	end)
	
	self:SetScript("OnLeave", function()
		Minimap.MinimapZone:SetAlpha(1)
		Minimap.MinimapCoords:SetAlpha(0)
	end)
	
	MiniMapTrackingButton:SetScript("OnEnter", function()
		Minimap.MinimapZone:SetAlpha(1)
		Minimap.MinimapCoords:SetAlpha(1)
	end)
	
	MiniMapTrackingButton:SetScript("OnLeave", function()
		Minimap.MinimapZone:SetAlpha(1)
		Minimap.MinimapCoords:SetAlpha(0)
	end)
end
hooksecurefunc(Minimap, "EnableMouseOver", EnableMouseOver)