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
	DataTextLeft:Hide()
	DataTextRight:Hide()
	
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
	
	-- local testPanel = CreateFrame("Frame", nil, UIParent)
	-- testPanel:SkinFrame2px("Transparent")
	-- testPanel:Size(100, 100)
	-- testPanel:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	
	-- Create RobsonUI panels
	local ChatBackground = CreateFrame("Frame", "ChatBackground", UIParent)
	ChatBackground:RobSkin()
	ChatBackground:Size(390, 125)
	ChatBackground:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 10, 10)
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
	
	-- local DataText1 = CreateFrame("Frame", "DataText1", UIParent)
	-- DataText1:RobSkin()
	-- DataText1:Size(120, 16)
	-- DataText1:SetPoint("TOP", UIParent, "TOP", 0, -5)
	-- DataText1:CreateShadow()
	
	-- --Chat tab tests
	-- local ChatTab1 = CreateFrame("Frame", "ChatTab1", UIParent)
	-- ChatTab1:CreateOverlay()
	-- ChatTab1:CreateBorder(false, true)
	-- ChatTab1:Size(390, 20)
	-- ChatTab1:SetPoint("TOPLEFT", UIParent, "LEFT", 10, 0)
	
	-- ChatFrame1Tab:RobSkin()
	-- ChatFrame2Tab:RobSkin()
	-- ChatFrame3Tab:RobSkin()
	-- ChatFrame4Tab:RobSkin()
	-- GeneralDockManager:RobSkin()
	
	-- GeneralDockManager:ClearAllPoints()
	-- GeneralDockManager:SetPoint("LEFT", UIParent, "CENTER", 0, 0)
	
-- hooksecurefunc("FCF_SetTabPosition", function(chatFrame,x)
	-- local chatTab = _G[chatFrame:GetName().."Tab"];
	-- local chatID = chatTab:GetID()
	-- --chatTab:ClearAllPoints()
	-- --chatTab:Point("LEFT", ChatTab1, 0, 6)
	
	
	
	-- if chatID == 2 then
		-- chatTab:ClearAllPoints()
		-- chatTab:Point("CENTER", UIParent, "CENTER", 0, 0)
	-- end
-- end)
	
	
	-- local ChatTab2 = CreateFrame("Frame", "ChatTab2", UIParent)
	-- ChatTab2:CreateOverlay()
	-- ChatTab2:CreateBorder(false, true)
	-- ChatTab2:Size(96, 20)
	-- ChatTab2:SetPoint("LEFT", ChatTab1, "RIGHT", 1, 0)
	
	-- local ChatTab3 = CreateFrame("Frame", "ChatTab3", UIParent)
	-- ChatTab3:CreateOverlay()
	-- ChatTab3:CreateBorder(false, true)
	-- ChatTab3:Size(96, 20)
	-- ChatTab3:SetPoint("LEFT", ChatTab2, "RIGHT", 1, 0)
	
	-- local ChatTab4 = CreateFrame("Frame", "ChatTab4", UIParent)
	-- ChatTab4:CreateOverlay()
	-- ChatTab4:CreateBorder(false, true)
	-- ChatTab4:Size(96, 20)
	-- ChatTab4:SetPoint("LEFT", ChatTab3, "RIGHT", 1, 0)
	
	-- local DPSAddonBackground = CreateFrame("Frame", "DPSAddonBackground", UIParent)
	-- DPSAddonBackground:RobSkin()
	-- DPSAddonBackground:Size(195, 128)
	-- DPSAddonBackground:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -10, 10)
	-- DPSAddonBackground:SetFrameStrata("BACKGROUND")
	-- DPSAddonBackground:SetFrameLevel(1)
	-- DPSAddonBackground:SetBackdropColor(0.14, 0.15, 0.15, 0.8)
	-- --DPSAddonBackg	round:CreateShadow()
	
	-- local DamageAddonBackground = CreateFrame("Frame", "DamageAddonBackground", UIParent)
	-- DamageAddonBackground:RobSkin()
	-- DamageAddonBackground:Size(195, 128)
	-- DamageAddonBackground:SetPoint("BOTTOMRIGHT", DPSAddonBackground, "BOTTOMLEFT", 0, 0)
	-- DamageAddonBackground:SetFrameStrata("BACKGROUND")
	-- DamageAddonBackground:SetFrameLevel(1)
	-- DamageAddonBackground:SetBackdropColor(0.14, 0.15, 0.15, 0.8)
	-- --DamageAddonBackground:CreateShadow()
	
	-- local AddonBackground = CreateFrame("Frame", "AddonBackground", UIParent)
	-- AddonBackground:Size(390, 128)
	-- AddonBackground:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -10, 10)
	-- AddonBackground:CreateShadow()
	
end
hooksecurefunc(Panels, "Enable", Enable)
