local T, C, L = Tukui:unpack()

local ActionBars = T["ActionBars"]
local Panels = T["Panels"]

local function SkinButton(self)
	local Name = self:GetName()
	local Button = self
	local Icon = _G[Name.."Icon"]
	
	Button:CreateBorder(true, false)
	Button:HideInsets()
	
	Button:SetBackdrop(nil)
	Button:HideInsets()
	--Icon:SetAllPoints()
end
hooksecurefunc(ActionBars, "SkinButton", SkinButton)

local function ShowAllButtons(self, bar, num)
	local Button

	for i = 1, NUM_ACTIONBAR_BUTTONS do
		Button = bar["Button"..i]
		Button:Show()
	end

	if (num == 2 or num == 3) then
		bar:Width((C.ActionBars.NormalButtonSize * 6) + (C.ActionBars.ButtonSpacing * 2))
	elseif (num == 5) then
		bar:Height((C.ActionBars.NormalButtonSize * 12) + (C.ActionBars.ButtonSpacing * 12))
	end
end
hooksecurefunc(ActionBars, "ShowAllButtons", ShowAllButtons)

local function RemoveColumn(self, bar, num)
	-- Remove some of the panel when ActionBars:RemoveColumn fires
	bar:Width((C.ActionBars.NormalButtonSize * (bar.NextColumnToHide)) + (C.ActionBars.ButtonSpacing + 1))
end
hooksecurefunc(ActionBars, "RemoveColumn", RemoveColumn)

local function RemoveButton(self, bar, num)
	-- Remove some of the panel when ActionBars:RemoveButton fires
	bar:Height((C.ActionBars.NormalButtonSize * (bar.NextButtonToHide)) + (C.ActionBars.ButtonSpacing + 1))
end
hooksecurefunc(ActionBars, "RemoveButton", RemoveButton)

local function ShowTopButtons(self, bar)
	-- Remove some of the panel when ActionBars:ShowTopButton fires
	bar:Height((C.ActionBars.NormalButtonSize * 2) + (C.ActionBars.ButtonSpacing * 2))
end
hooksecurefunc(ActionBars, "ShowTopButtons", ShowTopButtons)

-- ActionBar Highlighting 
local ShowOverlayGlow = function(self)
    if (self.overlay) then
        if (self.overlay.animOut:IsPlaying()) then
            self.overlay.animOut:Stop()
            self.overlay.animIn:Play()
        end
    else
		local Width, Height = self:GetSize()
		
        self.overlay = ActionButton_GetOverlayGlow()
        self.overlay:SetParent(self)
        self.overlay:ClearAllPoints()
        self.overlay:SetSize(Width * 1.4, Height * 1.4)
        self.overlay:SetPoint("TOPLEFT", self, "TOPLEFT", -Width * 0.2, Height * 0.2)
        self.overlay:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", Width * 0.2, -Height * 0.2)
        self.overlay.animIn:Play()
    end
end

local HideOverlayGlow = function(self)
    if self.overlay then
        if self.overlay.animIn:IsPlaying() then
            self.overlay.animIn:Stop()
        end
		
        if self:IsVisible() then
            self.overlay.animOut:Play()
        else
            ActionButton_OverlayGlowAnimOutFinished(self.overlay.animOut)
        end
    end
end

local function ButtonHightlight(self)
	if (self.overlay) then
		if self.NewProc then
			self.NewProc:Hide()
		end
		
		self.overlay:Show()
		ShowOverlayGlow(self)
	else
		HideOverlayGlow(self)
	end
end
hooksecurefunc(ActionBars, "StartButtonHighlight", ButtonHightlight)

-- Skin the flyout buttons
local function CreateToggleButtons(self)
	for i = 2, 5 do
		local Button = T.Panels["ActionBar" .. i .. "ToggleButton"]
		
		Button:RobSkin()
		Button:CreateShadow()
	end
end
hooksecurefunc(ActionBars, "CreateToggleButtons", CreateToggleButtons)

local function SetUpExtraActionButton(self)

	local Zone = ZoneAbilityFrame
	local ZoneButton = Zone.SpellButton
	local XPBar = T.Miscellaneous.Experience.XPBar1
	
	--Zone:rSkinFrame()
	Zone:SetPoint("TOPRIGHT", Minimap, "BOTTOMRIGHT", 17, 2)
	
	ZoneButton:SetBackdrop(nil)
	ZoneButton:HideInsets()
	ZoneButton:Size(30, 30)
	ZoneButton:rSkinFrame()
	
	ZoneButton.StyleButton = function() end
	
	ZoneButton:rStyleButton()
	ZoneButton:CreateShadow()
	ZoneButton.Icon:SetAllPoints()

end
hooksecurefunc(ActionBars, "SetUpExtraActionButton", SetUpExtraActionButton)

local function CreateBar1(self)
	local Size = C.ActionBars.NormalButtonSize
	local Spacing = C.ActionBars.ButtonSpacing
	local ActionBar1 = Panels.ActionBar1

	ActionBar1:SetScript("OnEvent", function(self, event, unit, ...)
		if (event == "ACTIVE_TALENT_GROUP_CHANGED") then
			TukuiActionBars:UpdateBar1()
		elseif (event == "PLAYER_ENTERING_WORLD") then
			for i = 1, NUM_ACTIONBAR_BUTTONS do
				local Button = _G["ActionButton"..i]
				Button:Size(Size)
				Button:ClearAllPoints()
				Button:SetParent(self)
					
				if (i == 1) then
					Button:SetPoint("BOTTOMLEFT", Spacing, Spacing)
				else
					local Previous = _G["ActionButton"..i-1]
					Button:SetPoint("LEFT", Previous, "RIGHT", 0, 0)
				end
			end
		else
			MainMenuBar_OnEvent(self, event, ...)
		end
	end)
end
hooksecurefunc(ActionBars, "CreateBar1", CreateBar1)

local function CreateBar2(self)
	local Size = C.ActionBars.NormalButtonSize
	local Spacing = C.ActionBars.ButtonSpacing
	local ActionBar2 = T.Panels.ActionBar2

	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local Button = _G["MultiBarBottomLeftButton"..i]
		local PreviousButton = _G["MultiBarBottomLeftButton"..i-1]

		Button:Size(Size)
		Button:ClearAllPoints()

		if (i == 1) then
			Button:SetPoint("BOTTOMRIGHT", ActionBar2, -Spacing, Spacing)
		elseif (i == 7) then
			Button:SetPoint("TOPRIGHT", ActionBar2, -Spacing, -Spacing)
		else
			Button:SetPoint("RIGHT", PreviousButton, "LEFT", 0, 0)
		end

		ActionBar2["Button"..i] = Button
	end
end
hooksecurefunc(ActionBars, "CreateBar2", CreateBar2)

local function CreateBar3(self)
	local Size = C.ActionBars.NormalButtonSize
	local Spacing = C.ActionBars.ButtonSpacing
	local ActionBar3 = T.Panels.ActionBar3
	
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local Button = _G["MultiBarBottomRightButton"..i]
		local PreviousButton = _G["MultiBarBottomRightButton"..i-1]

		Button:Size(Size)
		Button:ClearAllPoints()

		if (i == 1) then
			Button:SetPoint("BOTTOMLEFT", ActionBar3, Spacing, Spacing)
		elseif (i == 7) then
			Button:SetPoint("TOPLEFT", ActionBar3, Spacing, -Spacing)
		else
			Button:SetPoint("LEFT", PreviousButton, "RIGHT", 0, 0)
		end

		ActionBar3["Button"..i] = Button
	end
end
hooksecurefunc(ActionBars, "CreateBar3", CreateBar3)

local function CreateBar4(self)
	local Size = C.ActionBars.NormalButtonSize
	local Spacing = C.ActionBars.ButtonSpacing
	local ActionBar4 = T.Panels.ActionBar4
	
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local Button = _G["MultiBarRightButton"..i]
		local PreviousButton = _G["MultiBarRightButton"..i-1]

		Button:Size(Size)
		Button:ClearAllPoints()
		Button:SetAttribute("flyoutDirection", "UP")

		if (i == 1) then
			Button:SetPoint("TOPLEFT", ActionBar4, Spacing, -Spacing)
		else
			Button:SetPoint("LEFT", PreviousButton, "RIGHT", 0, 0)
		end

		ActionBar4["Button"..i] = Button
	end
end
hooksecurefunc(ActionBars, "CreateBar4", CreateBar4)

local function CreateBar5(self)
	local Size = C.ActionBars.NormalButtonSize
	local Spacing = C.ActionBars.ButtonSpacing
	local ActionBar5 = T.Panels.ActionBar5
	
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local Button = _G["MultiBarLeftButton"..i]
		local PreviousButton = _G["MultiBarLeftButton"..i-1]

		Button:Size(Size)
		Button:ClearAllPoints()

		if (i == 1) then
			Button:SetPoint("TOPRIGHT", ActionBar5, -Spacing, -Spacing)
		else
			Button:SetPoint("TOP", PreviousButton, "BOTTOM", 0, 0)
		end

		ActionBar5["Button"..i] = Button
	end
end
hooksecurefunc(ActionBars, "CreateBar5", CreateBar5)

local function CreateVehicleButtons()
	local VehicleLeft = T.Panels.VehicleButtonLeft
	local VehicleRight = T.Panels.VehicleButtonRight
	local Minimap = T.Maps.Minimap
	
	VehicleLeft:Kill()
	
	-- local VehicleButton = CreateFrame("Frame", "VehicleButton", UIParent)
	-- VehicleButton:Size(Minimap:GetWidth(), 20)
	-- VehicleButton:SetPoint("TOP", Minimap, "BOTTOM", 0, -5)
	
	-- VehicleRight:ClearAllPoints()
	-- --VehicleRight:Size(Minimap:GetWidth(), 20)
	-- --VehicleRight:SetPoint("TOP", Minimap, "BOTTOM", 0, -5)
	-- VehicleRight:SetAllPoints(VehicleButton)
	-- VehicleRight:RobSkin()
	-- VehicleRight:CreateShadow()
	
	-- --VehicleRight.SkinButton = function() end
	-- VehicleRight:rStyleButton()
	
	-- VehicleRight.Text:Hide()

end
hooksecurefunc(ActionBars, "CreateVehicleButtons", CreateVehicleButtons)

local function AddPanels()
	local Bar1 = T.Panels.ActionBar1
	local Bar2 = T.Panels.ActionBar2
	local Bar3 = T.Panels.ActionBar3
	local Bar4 = T.Panels.ActionBar4
	local Bar5 = T.Panels.ActionBar5
	local Bar6 = T.Panels.PetActionBar
	local Bar7 = T.Panels.StanceBar
	
	local Size = C.ActionBars.NormalButtonSize
	local Spacing = C.ActionBars.ButtonSpacing
	
	Bar1:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 10)
	Bar1.Backdrop:SetFrameStrata("BACKGROUND")
	Bar1:SetWidth((Size * 12) + (Spacing * 2))
	Bar1:SetHeight((Size * 1) + (Spacing * 2))
	
	Bar2:SetPoint("BOTTOMRIGHT", Bar1, "BOTTOMLEFT", -5, 0)
	Bar2.Backdrop:SetFrameStrata("BACKGROUND")
	Bar2:SetWidth((Size * 6) + (Spacing * 2))
	Bar2:SetHeight((Size * 2) + (Spacing * 2))
	
	Bar3:SetPoint("BOTTOMLEFT", Bar1, "BOTTOMRIGHT", 5, 0)
	Bar3.Backdrop:SetFrameStrata("BACKGROUND")
	Bar3:SetWidth((Size * 6) + (Spacing * 2))
	Bar3:SetHeight((Size * 2) + (Spacing * 2))
	
	Bar4:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 10)
	Bar4.Backdrop:SetFrameStrata("BACKGROUND")
	Bar4:SetWidth((Size * 12) + (Spacing * 2))
	Bar4:SetHeight((Size * 2) + (Spacing * 2))
	
	Bar5:SetPoint("RIGHT", UIParent, "RIGHT", -10, 0)
	Bar5.Backdrop:SetFrameStrata("BACKGROUND")
	Bar5:SetHeight((Size * 12) + (Spacing * 2))

	if (not C.ActionBars.HideBackdrop) then			
		local skin_panel = {
						Bar1.Backdrop,
						Bar2.Backdrop,
						Bar3.Backdrop,
						Bar4.Backdrop,
						Bar5.Backdrop,
						--Bar6.Backdrop,
						Bar7.Backdrop,
						}
		for _, panel in pairs(skin_panel) do
			panel:CreateOverlay()
			panel:RobSkin()
			panel:CreateShadow("Default")
		end
		
		-- Small update function to fix overlapping issue.
		if Bar4:IsShown() then
			Bar1.Backdrop:SetAlpha(0)
		end

		Bar4:HookScript("OnShow", function()
			Bar1.Backdrop:SetAlpha(0)
		end)

		Bar4:HookScript("OnHide", function()
			Bar1.Backdrop:SetAlpha(1)
		end)
	end
	
end
hooksecurefunc(ActionBars, "AddPanels", AddPanels)