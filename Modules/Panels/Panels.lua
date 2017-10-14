local T, C, L = Tukui:unpack()

local Panels = T.Panels

local function Enable(self)
	local BottomLine = Panels.BottomLine
	local LeftVerticalLine = Panels.LeftVerticalLine
	local RightVerticalLine = Panels.RightVerticalLine
	local DataTextLeft = Panels.DataTextLeft
	local DataTextRight = Panels.DataTextRight
	local CubeLeft = Panels.CubeLeft
	local CubeRight = Panels.CubeRight
	local LeftChatBG = Panels.LeftChatBG
	local RightChatBG = Panels.RightChatBG
	local TabsBGLeft = Panels.TabsBGLeft
	local TabsBGRight = Panels.TabsBGRight
	
	-- Hide default Tukui panels
	BottomLine:Hide()
	LeftVerticalLine:Hide()
	RightVerticalLine:Hide()
	--DataTextLeft:Hide()
	--DataTextRight:Hide()
	
	if CubeLeft and CubeRight then
		CubeLeft:Hide()
		CubeRight:Hide()
	end
	
	if  C["Chat"]["Background"] then
		LeftChatBG:Hide()
		RightChatBG:Hide()
		TabsBGLeft:Hide()
		TabsBGRight:Hide()
	end
	
	
	DataTextLeft:ClearAllPoints()
	DataTextLeft:Size(390, 23)
	DataTextLeft:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 10, 10)
	DataTextLeft:StripTextures()
	
	DataTextRight:ClearAllPoints()
	DataTextRight:Size(390, 23)
	DataTextRight:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -10, 10)
	DataTextRight:StripTextures()
	
	-- local testPanel = CreateFrame("Frame", "TestPanel", UIParent)
	-- testPanel:SkinFrame2px("Transparent")
	-- testPanel:Size(100, 20)
	-- testPanel:SetPoint("CENTER", UIParent, "CENTER", 0, 100)
	
	-- Create RobsonUI panels
	local ChatBackground = CreateFrame("Frame", "ChatBackground", UIParent)
	ChatBackground:RobSkin()
	--ChatBackground:Size(390, 125)
	ChatBackground:Size(390, 148)
	ChatBackground:SetPoint("BOTTOMLEFT", DataTextLeft, "TOPLEFT", 0, -23)
	ChatBackground:SetFrameStrata("BACKGROUND")
	ChatBackground:SetFrameLevel(1)
	ChatBackground:SetBackdropColor(0.18, 0.18, 0.18, 0.8)
	ChatBackground:CreateShadow()
	
	local ChatTabBackground = CreateFrame("Frame", "ChatTabBackground", ChatBackground)
	ChatTabBackground:CreateOverlay()
	ChatTabBackground.overlay:SetVertexColor(0.2, 0.2, 0.2)
	ChatTabBackground:CreateBorder(false, true)
	ChatTabBackground:Size(ChatBackground:GetWidth(), 20)
	ChatTabBackground:Point("TOPLEFT", 0, 0)
	
	local SkadaBackground = CreateFrame("Frame", "SkadaBackground", UIParent)
	SkadaBackground:RobSkin()
	SkadaBackground:Size(390, 148)
	SkadaBackground:SetPoint("BOTTOMRIGHT", DataTextRight, "TOPRIGHT", 0, -23)
	SkadaBackground:SetFrameStrata("BACKGROUND")
	SkadaBackground:SetFrameLevel(1)
	SkadaBackground:SetBackdropColor(0.18, 0.18, 0.18, 0.8)
	SkadaBackground:CreateShadow()
	
	local MinimapBackground = CreateFrame("Frame", "MinimapBackground", UIParent)
	MinimapBackground:RobSkin()
	MinimapBackground:Size(Minimap:GetWidth(), Minimap:GetHeight() + 19)
	MinimapBackground:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -10, -10)
	MinimapBackground:CreateShadow()
	MinimapBackground:SetFrameStrata("BACKGROUND")
	
	local AltPowerBarPanel = CreateFrame("Frame", "AltPowerBarPanel", UIParent)
	AltPowerBarPanel:Size(370, 23)
	AltPowerBarPanel:SetPoint("TOP", UIParent, "TOP", 0, -10)
	AltPowerBarPanel:SetFrameStrata("BACKGROUND")
	AltPowerBarPanel:SetFrameLevel(1)
	
	self.ChatBackground = ChatBackground
	self.ChatTabBackground = ChatTabBackground
	self.MinimapBackground = MinimapBackground
	self.AltPowerBarPanel = AltPowerBarPanel
	
	-- self.TestPanel = TestPanel	
end
hooksecurefunc(Panels, "Enable", Enable)
