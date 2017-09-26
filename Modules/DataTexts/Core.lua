local T, C, L = Tukui:unpack()

local TukuiDT = T["DataTexts"]

-- local function CreateAnchors(self)
	-- -- local Panels = T["Panels"]
	-- -- DataTextLeft = Panels.DataTextLeft
	-- -- DataTextRight = Panels.DataTextRight
	-- -- MinimapDataTextOne = Panels.MinimapDataTextOne
	-- -- MinimapDataTextTwo = Panels.MinimapDataTextTwo

	-- -- if (MinimapDataTextOne and MinimapDataTextTwo) then
		-- -- self.NumAnchors = self.NumAnchors + 2
	-- -- end

	-- -- for i = 1, self.NumAnchors do
		-- -- local Frame = CreateFrame("Button", nil, UIParent)
		-- -- Frame:Size((DataTextLeft:GetWidth() / 3) - 1, DataTextLeft:GetHeight() - 2)
		-- -- Frame:SetFrameLevel(DataTextLeft:GetFrameLevel() + 1)
		-- -- Frame:SetFrameStrata("HIGH")
		-- -- Frame:EnableMouse(false)
		-- -- Frame.SetData = SetData
		-- -- Frame.RemoveData = RemoveData
		-- -- Frame.Num = i

		-- -- Frame.Tex = Frame:CreateTexture()
		-- -- Frame.Tex:SetAllPoints()
		-- -- Frame.Tex:SetColorTexture(0.2, 1, 0.2, 0)

		-- -- self.Anchors[i] = Frame

		-- -- if (i == 1) then
			-- -- Frame:Point("LEFT", DataTextLeft, 1, 0)
		-- -- elseif (i == 4) then
			-- -- Frame:Point("LEFT", DataTextRight, 1, 0)
		-- -- elseif (i == 7) then
			-- -- Frame:Point("CENTER", MinimapDataTextOne, 0, 0)
			-- -- Frame:Size(MinimapDataTextOne:GetWidth() - 2, MinimapDataTextOne:GetHeight() - 2)
		-- -- elseif (i == 8) then
			-- -- Frame:Point("CENTER", MinimapDataTextTwo, 0, 0)
			-- -- Frame:Size(MinimapDataTextTwo:GetWidth() - 2, MinimapDataTextTwo:GetHeight() - 2)
		-- -- elseif (i == 9) then
			-- -- Frame:Point("CENTER", DataText1, 0, 0)
			-- -- Frame:Size(DataText1:GetWidth(), - 2, DataText1:GetHeight() -2)
		-- -- else
			-- -- Frame:Point("LEFT", self.Anchors[i-1], "RIGHT", 1, 0)
		-- -- end
	-- -- end
-- end
-- hooksecurefunc(TukuiDT, "CreateAnchors", CreateAnchors)