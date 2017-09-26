local T, C, L = Tukui:unpack()

if not IsAddOnLoaded("Skada") then return end

local Panels = T.Panels

local Skada = Skada
local barmod = Skada.displays["bar"]
local barSpacing = T.Scale(1, 1)
local borderWidth = T.Scale(2, 2)

local SkadaDisplayBar = Skada.displays["bar"]

hooksecurefunc(SkadaDisplayBar, "Update", function(self, win)
	
	for i, data in ipairs(win.dataset) do
		if data.id then
			local barid = data.id
			local barlabel = data.label

			local bar = win.bargroup:GetBar(barid)
			
			-- local textureFrame = CreateFrame("Frame", nil, bar)
			-- textureFrame:SetAllPoints(bar.texture)
			-- textureFrame:CreateBorder(false, true)
			-- textureFrame:SetFrameLevel(bar:GetFrameLevel() - 1)
			
			--bar.texture:CreateBorder(false, true)
			
			--bar:CreateBorder(false, true)
			bar.bgtexture:SetVertexColor(0, 0, 0, 0)
		end
	end
end)

local function StripOptions(options)
	options.baroptions.args.barspacing = nil
	options.titleoptions.args.texture = nil
	options.titleoptions.args.bordertexture = nil
	options.titleoptions.args.thickness = nil
	options.titleoptions.args.margin = nil
	options.titleoptions.args.color = nil
	options.windowoptions = nil
	options.baroptions.args.barfont = nil
	options.titleoptions.args.font = nil
end

barmod.AddDisplayOptions_ = barmod.AddDisplayOptions
barmod.AddDisplayOptions = function(self, win, options)
	self:AddDisplayOptions_(win, options)
	StripOptions(options)
end

for k, options in pairs(Skada.options.args.windows.args) do
	if(options.type == "group") then
		StripOptions(options.args)
	end
end

local titleBG = {
	bgFile = C["Medias"].Normal,
	tile = false,
	tileSize = 0
}

barmod.ApplySettings_ = barmod.ApplySettings
barmod.ApplySettings = function(self, win)
	barmod.ApplySettings_(self, win)

	local skada = win.bargroup

	if(win.db.enabletitle) then
		skada.button:SetBackdrop(titleBG)
		--skada.button:SetScript("OnEnter", function(self) skada.button:Show() end)
		--skada.button:SetScript("OnLeave", function(self) skada.button:Hide() end)
	end

	skada:SetTexture(C["Medias"].Normal)
	skada:SetSpacing(barSpacing)
	skada:SetFont(C["Medias"].Font, 12, "THINOUTLINE")
	skada:SetFrameLevel(5)
	
	if not skada.TitleBackGround then
		skada.TitleBackGround = CreateFrame("Frame", nil, skada.button)
		skada.TitleBackGround:SetPoint("TOP")
		skada.TitleBackGround:SetPoint("LEFT")
		skada.TitleBackGround:SetPoint("RIGHT")
		skada.TitleBackGround:SetPoint("BOTTOM", 0, 1)
		skada.TitleBackGround:RobSkin()
		skada.TitleBackGround:CreateShadow()
		skada.TitleBackGround:SetFrameLevel(skada.button:GetFrameLevel() -1)
	end
	
	local titlefont = CreateFont("TitleFont" .. win.db.name)
	titlefont:SetFont(C["Medias"].Font, 12, "OUTLINE")
	skada.button:SetNormalFontObject(titlefont)

	local color = win.db.title.color
	skada.button:SetBackdropColor(0, 0, 0, 0)

	skada:SetBackdrop(nil)
	if not skada.backdrop then
		--skada:CreateBackdrop("Default")
		skada:RobSkin()
		skada:CreateShadow()
		-- Try new color for backdrop
		skada:SetBackdropColor(0.18, 0.18, 0.18, 0.8)
	end
	
	skada:SetTexture("Interface\\AddOns\\RobsonUI\\Core\\Textures\\Skullflower.tga")
	
	-- Setup the profile
	win.db.background.height = 125
	win.db.barwidth = 390
	win.db.barheight = 19
	win.db.spark = false
	win.db.barslocked = true
	win.db.classicons = false
	win.db.enabletitle = false
	
	win.bargroup:ClearAllPoints()
	win.bargroup:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -10, 10)
	
	Skada.db.profile.showranks = false
	Skada.db.profile.updatefrequence = 0.1
	

	-- skada.Backdrop:ClearAllPoints()
	-- if(win.db.enabletitle) then
		-- skada.Backdrop:Point("TOPLEFT", skada.button, "TOPLEFT", -2, 2)
	-- else
		-- skada.Backdrop:Point("TOPLEFT", skada, "TOPLEFT", -2, 2)
	-- end
	-- skada.Backdrop:Point("BOTTOMRIGHT", skada, "BOTTOMRIGHT", 2, -2)
end


-- Implement second window when the skinning is done

-- local windows = {}
-- function EmbedSkada()
	-- if #windows == 1 then
		-- EmbedWindow(windows[1], TukuiChatBackgroundRight:GetWidth() - 4,   (TukuiChatBackgroundRight:GetHeight() - 4 - (barSpacing * 4)) / 10, (TukuiChatBackgroundRight:GetHeight() - 6), "BOTTOMRIGHT", TukuiChatBackgroundRight, "BOTTOMRIGHT", -2, 3)
	-- elseif #windows == 2 then
		-- EmbedWindow(windows[1], ((TukuiChatBackgroundRight:GetWidth() - 4) / 2) - (borderWidth + T.mult), (TukuiChatBackgroundRight:GetHeight() - 4 - (barSpacing * 4)) / 10, TukuiChatBackgroundRight:GetHeight() - 4,    "BOTTOMRIGHT", TukuiChatBackgroundRight, "BOTTOMRIGHT", -2, 3)
		-- EmbedWindow(windows[2], ((TukuiChatBackgroundRight:GetWidth() - 4) / 2) - (borderWidth + T.mult), (TukuiChatBackgroundRight:GetHeight() - 4 - (barSpacing * 4)) / 10, TukuiChatBackgroundRight:GetHeight() - 4,    "BOTTOMLEFT", TukuiChatBackgroundRight, "BOTTOMLEFT", 2, 3)
	-- elseif #windows > 2 then
		-- EmbedWindow(windows[1], ((TukuiChatBackgroundRight:GetWidth() - 4) / 2) - (borderWidth + T.mult), (TukuiChatBackgroundRight:GetHeight() - 4 - (barSpacing * 4)) / 10, TukuiChatBackgroundRight:GetHeight() - 4,    "BOTTOMRIGHT", TukuiChatBackgroundRight, "BOTTOMRIGHT", -2, 3)
		-- EmbedWindow(windows[2], ((TukuiChatBackgroundRight:GetWidth() - 4) / 2) - (borderWidth + T.mult), ((TukuiChatBackgroundRight:GetHeight() - 6 / 2) - (barSpacing * 4)) / 10, TukuiChatBackgroundRight:GetHeight() - 4 / 2 - 2,  "BOTTOMLEFT", TukuiChatBackgroundRight, "BOTTOMLEFT", 2, 3)
		-- EmbedWindow(windows[3], windows[2].db.barwidth -1 , ((TukuiChatBackgroundRight:GetHeight() - 6 / 2) - (barSpacing * 4)) / 10, TukuiChatBackgroundRight:GetHeight() - 4 / 2 - 2,  "BOTTOMLEFT", windows[2].bargroup.backdrop, "TOPLEFT", 2, 4)
	-- end
-- end

-- -- Update pre-existing displays
-- for _, window in ipairs(Skada:GetWindows()) do
	-- window:UpdateDisplay()
-- end



-- function LoadSkadaProfile()
	-- SkadaDB["profiles"]["RobsonUI"] = {

-- }
	-- Skada.db:SetProfile("RobsonUI") -- set automatically the profile
-- end

-- ProfileButton = CreateFrame("Button", nil, UIParent)
-- ProfileButton:Point("CENTER", UIParent, "CENTER", 0, -150)
-- ProfileButton:Size(20, 20)
-- ProfileButton:RobSkin()
-- ProfileButton:CreateShadow()
-- ProfileButton:FontString("Text", C.Medias.Font, 12)
-- ProfileButton.Text:SetPoint("CENTER")
-- ProfileButton.Text:SetText(CLOSE)
-- ProfileButton:SetScript("OnClick", function() LoadSkadaProfile() end)


