-- local T, C, L = Tukui:unpack()

-- local UnitFrames = T.UnitFrames
-- local Noop = function() end
-- local Panels = T["Panels"]

-- local function Player(self)
	-- local Panel = self.Panel
	-- local Health = self.Health
	-- local Power = self.Power
	-- local CastBar = self.Castbar
	
	-- self:SetBackdrop(nil)
	-- Panel:Kill()

	-- Health:ClearAllPoints()
	-- Health:SetPoint("TOP", self, "TOP", 0, 0)
	-- Health:Size(220, 33)
	-- Health:RobSkin()

	-- Health.Value:ClearAllPoints()
	-- Health.Value:Point("LEFT", Health, "LEFT", 5, 0)
	
	-- if DarkTheme then
		-- Health.colorTapping = false
		-- Health.colorDisconnected = false
		-- Health.colorClass = false
		-- Health:SetStatusBarColor(0.2, 0.2, 0.2, 1)
		-- Health.Background:SetVertexColor(0, 0, 0, 1)
	-- else
		-- Health.colorTapping = true
		-- Health.colorDisconnected = true
		-- Health.colorClass = false
		-- Health:SetStatusBarColor(0.3, 0.3, 0.3, 1)
		-- Health.colorReaction = false
	-- end
	
	-- Power:Height(10)
	-- Power:RobSkin()
	-- Power.Value:Hide()
	
	-- if DarkTheme then
		-- Power.colorTapping = true
		-- Power.colorClass = true
		-- Power.Background.multiplier = 0.1
	-- else
		-- Power.colorPower = false
		-- Power.colorClass = true
	-- end

	-- -- Now let's move the player cast bar in the middle of the screen.
	-- CastBar:ClearAllPoints()
	-- CastBar:SetWidth(400)
	-- CastBar:SetHeight(25)
	-- CastBar:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 100)
	-- CastBar:RobSkin()
	-- CastBar:CreateShadow()

	-- -- Icon, Text, Time positions are wrong, update them
	-- CastBar.Icon:ClearAllPoints()
	-- CastBar.Icon:SetPoint("RIGHT", CastBar, "LEFT", 0, 0)
	-- CastBar.Icon:SetSize(CastBar:GetHeight(), CastBar:GetHeight())
	
	-- CastBar.Button:ClearAllPoints()
	-- CastBar.Button:SetOutside(CastBar.Icon)
	-- CastBar.Button:SetBackdrop(nil)
	-- CastBar.Button:CreateBorder(true, false)
	-- CastBar.Button:HideInsets()

	-- CastBar.Time:ClearAllPoints()
	-- CastBar.Time:Point("RIGHT", CastBar, "RIGHT", -4, 0)
	
	-- CastBar.Text:ClearAllPoints()
	-- CastBar.Text:Point("LEFT", CastBar, "LEFT", 4, 0)
-- end
-- hooksecurefunc(UnitFrames, "Player", Player)

