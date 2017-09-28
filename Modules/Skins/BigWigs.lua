local T, C, L = Tukui:unpack()

local IsAddOnLoaded = IsAddOnLoaded
local Noop = function() return end

if not IsAddOnLoaded("BigWigs") then return end

local FreeBackgrounds = {}
local buttonsize = 20

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

	bar.candyBarDuration:ClearAllPoints()
	bar.candyBarDuration:SetPoint("LEFT", bar, "LEFT", 2, 0)
	bar.candyBarDuration:SetPoint("RIGHT", bar, "RIGHT", -2, 0)
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
		GetSpacing = function() return 18 end,
		ApplyStyle = ApplyStyle,
		BarStopped = FreeStyle,
		GetStyleName = function() return styleName end,
	})
	bars.defaultDB.barStyle = styleName
end
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_LOGIN")

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
