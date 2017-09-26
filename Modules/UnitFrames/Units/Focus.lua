-- local T, C, L = Tukui:unpack()

-- local UnitFrames = T.UnitFrames
-- local Noop = function() end
-- local Panels = T["Panels"]

-- local function Target(self)
	-- local Buffs = self.Buffs
	-- local Debuffs = self.Debuffs
	-- local CastBar = self.Castbar
	-- local Panel = self.Panel
	-- local Health = self.Health
	-- local Power = self.Power
	
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
		-- Health.colorReaction = true
	-- end	

	-- Power:Height(10)
	-- Power:RobSkin()
	-- Power.Value:Hide()

	-- if DarkTheme then
		-- Power.colorTapping = true
		-- Power.colorClass = true
		-- Power.colorClassNPC = true
		-- Power.colorClassPet = true
		-- Power.Background.multiplier = 0.1
	-- else
		-- Power.colorPower = false
		-- Power.colorClass = true
	-- end
	
	
	
	-- -- -- move buffs
	-- Buffs:ClearAllPoints()
	-- Buffs:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, -4)
	
	-- -- -- at this point, we see that the buffs are back at top, so we assume there is a 
	-- -- -- post function active which set position. We need to find it and edit it.
	-- -- UnitFrames.UpdateBuffsHeaderPosition = Noop
	
	-- -- -- Now we need to change "growth-y" parameter from UP to BOTTOM
	-- -- Buffs["growth-y"] = "DOWN"
	
	-- -- -- move debuffs
	-- Debuffs:ClearAllPoints()
	-- Debuffs:SetPoint("TOPLEFT", Buffs, "BOTTOMLEFT", -2, 2)
	
	-- -- -- Now we need to change "growth-y" parameter from UP to BOTTOM
	-- -- Debuffs["growth-y"] = "DOWN"
	
	-- -- -- Now let's move the target cast bar in the middle of the screen.
	-- -- CastBar:ClearAllPoints()
	-- -- CastBar:SetWidth(300)
	-- -- CastBar:SetHeight(30)
	-- -- CastBar:SetPoint("TOP", UIParent, "TOP", 0, -300)
	
	-- -- -- There is no backdrop by default, create one, it look better!
	-- -- CastBar:CreateBackdrop()
	
	-- -- -- Icon, Text, Time positions are wrong, update them
	-- -- CastBar.Icon:ClearAllPoints()
	-- -- CastBar.Icon:SetPoint("RIGHT", CastBar, "LEFT", -8, 0)
	-- -- CastBar.Icon:SetSize(CastBar:GetHeight(), CastBar:GetHeight())
	-- -- CastBar.Button:ClearAllPoints()
	-- -- CastBar.Button:SetOutside(CastBar.Icon)
	-- -- CastBar.Time:ClearAllPoints()
	-- -- CastBar.Time:Point("RIGHT", CastBar, "RIGHT", -4, 0)
	-- -- CastBar.Text:ClearAllPoints()
	-- -- CastBar.Text:Point("LEFT", CastBar, "LEFT", 4, 0)
-- end
-- hooksecurefunc(UnitFrames, "Target", Target)
