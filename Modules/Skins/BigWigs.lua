local T, C, L = Tukui:unpack()

local IsAddOnLoaded = IsAddOnLoaded
local Noop = function() return end

if not IsAddOnLoaded("BigWigs") then return end

local FreeBackgrounds = {}
local buttonsize = 24
local Popups = T["Popups"]

local function CreateBG()
	local BG = CreateFrame("Frame")
	BG:RobSkin()
	
	return BG
end

local function FreeStyle(bar)
	local bg = bar:Get("bigwigs:RobsonUI:bg")
	if bg then 
		bg:ClearAllPoints()
		bg:SetParent(UIParent)
		bg:Hide()
		FreeBackgrounds[#FreeBackgrounds + 1] = bg
	end
	
	local ibg = bar:Get("bigwigs:RobsonUI:ibg")
	if ibg then
		ibg:ClearAllPoints()
		ibg:SetParent(UIParent)
		ibg:Hide()
		FreeBackgrounds[#FreeBackgrounds + 1] = ibg
	end
	
	-- Icon
	bar.candyBarIconFrame:ClearAllPoints()
	bar.candyBarIconFrame:SetPoint("TOPLEFT")
	bar.candyBarIconFrame:SetPoint("BOTTOMLEFT")
	bar.candyBarIconFrame:SetTexCoord(0.07, 0.93, 0.07, 0.93)
	
	-- Status Bar
	bar.candyBarBar:ClearAllPoints()
	bar.candyBarBar:SetPoint("TOPLEFT")
	bar.candyBarBar:SetPoint("BOTTOMLEFT")
	
	-- Background
	bar.candyBarBackground:SetAllPoints()
	
	-- Duration
	bar.candyBarDuration:ClearAllPoints()
	bar.candyBarDuration:SetPoint("RIGHT", bar.candyBarBar, "RIGHT", -2, 0)

	-- Name
	bar.candyBarLabel:ClearAllPoints()
	bar.candyBarLabel:SetPoint("LEFT", bar.candyBarBar, "LEFT", 2, 0)
	bar.candyBarLabel:SetPoint("RIGHT", bar.candyBarBar, "RIGHT", -2, 0)
end

local function ApplyStyle(bar)
	-- General bar settings
	bar.OldHeight = bar:GetHeight()
	bar.OldScale = bar:GetScale()
	bar.OldSetScale = bar.SetScale
	bar.SetScale = Noop
	bar:Height(buttonsize)
	bar:SetScale(1)

	local bg = nil
		if #FreeBackgrounds > 0 then
			bg = tremove(FreeBackgrounds)
		else
			bg = CreateBG()
		end
	
	bg:SetParent(bar)
	bg:SetFrameStrata(bar:GetFrameStrata())
	bg:SetFrameLevel(bar:GetFrameLevel() - 1)
	bg:ClearAllPoints()
	bg:SetAllPoints(bar)
	bg:RobSkin()
	bg:CreateShadow()
	bg:Show()
	bar:Set("bigwigs:RobsonUI:bg", bg)

	if bar.candyBarIconFrame:GetTexture() then
		local ibg
		if #FreeBackgrounds > 0 then
			ibg = tremove(FreeBackgrounds)
		else
			ibg = CreateBG()
		end
		ibg:SetParent(bar)
		ibg:SetFrameStrata(bar:GetFrameStrata())
		ibg:SetFrameLevel(bar:GetFrameLevel() - 1)
		ibg:ClearAllPoints()
		ibg:SetAllPoints(bar.candyBarIconFrame)
		ibg:SetBackdropColor(0, 0, 0, 0)
		ibg:Show()
		ibg:CreateShadow()
		bar:Set("bigwigs:RobsonUI:ibg", ibg)
	end


	bar:SetHeight(buttonsize)

	bar.candyBarBar.OldPoint, bar.candyBarBar.Anchor, bar.candyBarBar.OldPoint2, bar.candyBarBar.XPoint, bar.candyBarBar.YPoint  = bar.candyBarBar:GetPoint()
	bar.candyBarBar:ClearAllPoints()
	bar.candyBarBar:SetAllPoints(bar)
	bar.candyBarBar.OldSetPoint = bar.candyBarBar.SetPoint
	bar.candyBarBar.SetPoint = Noop
	bar.candyBarBar:SetStatusBarTexture([[Interface\AddOns\RobsonUI\Core\Textures\Skullflower.tga]])
		if not bar.data["bigwigs:emphasized"] == true then
			bar.candyBarBar:SetStatusBarColor(0.3, 0.3, 0.3, 1)
		end
	
	bar.candyBarBackground:SetTexture(0.3, 0.3, 0.3, 1)

	bar.candyBarIconFrame.OldPoint, bar.candyBarIconFrame.Anchor, bar.candyBarIconFrame.OldPoint2, bar.candyBarIconFrame.XPoint, bar.candyBarIconFrame.YPoint  = bar.candyBarIconFrame:GetPoint()
	bar.candyBarIconFrame.OldWidth = bar.candyBarIconFrame:GetWidth()
	bar.candyBarIconFrame.OldHeight = bar.candyBarIconFrame:GetHeight()
	bar.candyBarIconFrame.OldSetWidth = bar.candyBarIconFrame.SetWidth
	bar.candyBarIconFrame:ClearAllPoints()
	bar.candyBarIconFrame:SetPoint("BOTTOMRIGHT", bar, "BOTTOMLEFT", -4, 0)
	bar.candyBarIconFrame:SetSize(buttonsize, buttonsize)
	bar.candyBarIconFrame.SetWidth = Noop
	bar.candyBarIconFrame:SetTexCoord(unpack(T.IconCoord))

	bar.candyBarLabel:ClearAllPoints()
	bar.candyBarLabel:SetPoint("LEFT", bar, "LEFT", 2, 0)
	bar.candyBarLabel:SetPoint("RIGHT", bar, "RIGHT", -2, 0)
	bar.candyBarLabel:SetFont("Interface\\AddOns\\RobsonUI\\Core\\Fonts\\ExpresswayRg.ttf", 12, "THINOUTLINE")

	bar.candyBarDuration:ClearAllPoints()
	bar.candyBarDuration:SetPoint("LEFT", bar, "LEFT", 2, 0)
	bar.candyBarDuration:SetPoint("RIGHT", bar, "RIGHT", -2, 0)
	bar.candyBarDuration:SetFont("Interface\\AddOns\\RobsonUI\\Core\\Fonts\\ExpresswayRg.ttf", 12, "THINOUTLINE")
end

local f = CreateFrame("Frame")
local function RegisterStyle()
	if not BigWigs then return end
		local styleName = "RobsonUI"
		local bars = BigWigs:GetPlugin("Bars", true)
	if not bars then return end
		bars:RegisterBarStyle(styleName, {
			apiVersion = 1,
			version = 1,
			GetSpacing = function() return 4 end,
			ApplyStyle = ApplyStyle,
			BarStopped = FreeStyle,
			GetStyleName = function() return styleName end,
	})
	bars.defaultDB.barStyle = styleName
end
f:RegisterEvent("ADDON_LOADED")
--f:RegisterEvent("PLAYER_LOGIN")

local reason = nil
f:SetScript("OnEvent", function(self, event, msg)
	if event == "ADDON_LOADED" then
		if not reason then reason = (select(6, GetAddOnInfo("BigWigs_Plugins"))) end
			if (reason == "MISSING" and msg == "BigWigs") or msg == "BigWigs_Plugins" then
				RegisterStyle()
		end
	elseif event == "PLAYER_LOGIN" then
		RegisterStyle()
	end
end)

function SetBigWigsProfile(layout)
		BigWigs3DB = {
			["namespaces"] = {
				["BigWigs_Plugins_Victory"] = {},
				["BigWigs_Plugins_Colors"] = {},
				["BigWigs_Plugins_Alt Power"] = {
					["profiles"] = {
						["RobsonUI"] = {
							["posx"] = 256,
							["fontSize"] = 12,
							["fontOutline"] = "THINOUTLINE",
							["font"] = "ExpresswayRg",
							["lock"] = true,
							["posy"] = 380,
						},
					},
				},
				["BigWigs_Plugins_BossBlock"] = {},
				["BigWigs_Plugins_Bars"] = {
					["profiles"] = {
						["RobsonUI"] = {
							["BigWigsEmphasizeAnchor_y"] = 596,
							["fontSize"] = 12,
							["BigWigsAnchor_width"] = 362,
							["BigWigsAnchor_y"] = 100,
							["BigWigsEmphasizeAnchor_x"] = 590,
							["barStyle"] = "RobsonUI",
							["emphasizeGrowup"] = true,
							["BigWigsAnchor_x"] = 1167,
							["outline"] = "THINOUTLINE",
							["BigWigsEmphasizeAnchor_width"] = 362,
							["font"] = "Expressway",
							["emphasizeScale"] = 1.0,
							["emphasizeMove"] = false,
							["texture"] = "Skullflower",
						},
					},
				},
				["BigWigs_Plugins_Super Emphasize"] = {
					["profiles"] = {
						["RobsonUI"] = {
							["font"] = "ExpresswayRg",
						},
					},
				},
				["BigWigs_Plugins_Sounds"] = {
				},
				["BigWigs_Plugins_InfoBox"] = {
					["profiles"] = {
						["RobsonUI"] = {
							["posx"] = 256,
							["posy"] = 318,
						},
					},
				},
				["BigWigs_Plugins_Messages"] = {
					["profiles"] = {
						["RobsonUI"] = {
							["outline"] = "OUTLINE",
							["BWEmphasizeMessageAnchor_x"] = 628.13343119721,
							["BWEmphasizeCountdownMessageAnchor_x"] = 669.866701602936,
							["BWEmphasizeMessageAnchor_y"] = 688.133369222283,
							["BWMessageAnchor_y"] = 645.599968566494,
							["BWMessageAnchor_x"] = 628.266634329157,
							["BWEmphasizeCountdownMessageAnchor_y"] = 505.400026358664,
							["font"] = "ExpresswayRg",
							["fontSize"] = 20,
							["growUpwards"] = false,
						},
					},
				},
				["BigWigs_Plugins_Statistics"] = {},
				["BigWigs_Plugins_Respawn"] = {},
				["BigWigs_Plugins_Proximity"] = {
					["profiles"] = {
						["RobsonUI"] = {
							["posx"] = 256.00,
							["font"] = "ExpresswayRg",
							["lock"] = true,
							["height"] = 100,
							["posy"] = 90,
						},
					},
				},
				["BigWigs_Plugins_Raid Icons"] = {},
				["LibDualSpec-1.0"] = {},
			},
			["profiles"] = {
				["RobsonUI"] = {
					["fakeDBMVersion"] = true,
				},
			},
		}
end


local pr = function(msg)
	print("|cff1784d1RobsonUI BigWigs Skin|r:", tostring(msg))
end

SLASH_ROBSONUIBW1 = "/rbw"
SlashCmdList["ROBSONUIBW"] = function(msg)
	if msg == "apply" then
		Popups.ShowPopup("ROBSONUI_ENABLE_BW_SKIN")
	else
		pr("use |cff1784d1/rbw apply|r to apply BigWigs settings.")
		--pr("use |cff1784d1/rbw test|r to launch DBM testmode.")
		--pr("use |cff1784d1/rbw bh|r to show test BossHealth frame.")
	end
end

Popups.Popup["ROBSONUI_ENABLE_BW_SKIN"] = {
	Question = "Enable the BigWigs skin",
	Answer1 = ACCEPT,
	Answer2 = CANCEL,
	Function1 = function(self)
		SetBigWigsProfile()
		if InCombatLockdown() then
			print(ERR_NOT_IN_COMBAT)
			print("Please reload your interface to apply BigWigs skin.")
		else
			ReloadUI()
		end
	end,
}