local T, C, L = Tukui:unpack()

local UnitFrames = T.UnitFrames
local Noop = function() end
local Panels = T["Panels"]

-- WoW Globals, localized because it's more efficient
local UnitIsEnemy = UnitIsEnemy
local UnitIsPlayer = UnitIsPlayer
local UnitIsFriend = UnitIsFriend
local UnitIsConnected = UnitIsConnected
local UnitPlayerControlled = UnitPlayerControlled
local UnitIsGhost = UnitIsGhost
local UnitIsDead = UnitIsDead
local UnitPowerType = UnitPowerType

local function UpdateNamePosition(self)
	if (self.Power.Value:GetText() and UnitIsEnemy("player", "target")) then
		self.Name:ClearAllPoints()
		self.Name:SetPoint("LEFT", self.Health, "LEFT", 3, 0)
	else
		self.Name:ClearAllPoints()
		self.Power.Value:SetAlpha(0)
		self.Name:SetPoint("LEFT", self.Health, "LEFT", 3, 0)
	end
end
hooksecurefunc(UnitFrames, "UpdateNamePosition", UpdateNamePosition)

function RobsonUIPreUpdateHealth(self, unit)
	local DarkTheme = C["UnitFrames"].DarkTheme
	local HostileColor = C["UnitFrames"].TargetEnemyHostileColor

	if (DarkTheme == true) or (HostileColor ~= true) then
		return
	end

	local Parent = self:GetParent()

	if UnitIsEnemy(unit, "player") then
		self.colorClass = false
	else
		self.colorClass = false
	end
end

function RobsonUIPostUpdateHealth(self, unit, min, max)
	if (not UnitIsConnected(unit) or UnitIsDead(unit) or UnitIsGhost(unit)) then
		if (not UnitIsConnected(unit)) then
			self.Value:SetText("|cffD7BEA5"..FRIENDS_LIST_OFFLINE.."|r")
		elseif (UnitIsDead(unit)) then
			self.Value:SetText("|cffD7BEA5"..DEAD.."|r")
		elseif (UnitIsGhost(unit)) then
			self.Value:SetText("|cffD7BEA5"..L.UnitFrames.Ghost.."|r")
		end
	else
		local r, g, b
		local IsRaid = string.match(self:GetParent():GetName(), "Button") or false

		if (min ~= max) then
			r, g, b = T.ColorGradient(min, max, 0.69, 0.31, 0.31, 0.65, 0.63, 0.35, 0.33, 0.59, 0.33)
			if (unit == "player" and self:GetAttribute("normalUnit") ~= "pet") then
				if (IsRaid) then
					self.Value:SetText("|cffff2222-"..UnitFrames.ShortValue(max-min).."|r")
				else
					--self.Value:SetFormattedText("|cffAF5050%d|r |cffD7BEA5-|r |cff%02x%02x%02x%d%%|r", min, r * 255, g * 255, b * 255, floor(min / max * 100))
					self.Value:SetFormattedText(""..UnitFrames.ShortValue(min).."|r")
				end
			elseif (unit == "target" or (unit and strfind(unit, "boss%d"))) then
				--self.Value:SetFormattedText("|cffAF5050%s|r |cffD7BEA5-|r |cff%02x%02x%02x%d%%|r", UnitFrames.ShortValue(min), r * 255, g * 255, b * 255, floor(min / max * 100))
				self.Value:SetFormattedText(""..UnitFrames.ShortValue(min).."|r")
			elseif (unit and strfind(unit, "arena%d")) or (unit == "focus") or (unit == "focustarget") then
				self.Value:SetText("|cff559655"..UnitFrames.ShortValue(min).."|r")
			else
				self.Value:SetText("|cffff2222-"..UnitFrames.ShortValue(max-min).."|r")
			end
		else
			if (unit == "player" and self:GetAttribute("normalUnit") ~= "pet") then
				if (IsRaid) then
					self.Value:SetText(" ")
				else
					--self.Value:SetText("|cff559655"..UnitFrames.ShortValue(max).."|r")
					self.Value:SetText(""..UnitFrames.ShortValue(max).."|r")				
				end
			elseif (unit == "target" or unit == "focus"  or unit == "focustarget" or (unit and strfind(unit, "arena%d")) or (unit and strfind(unit, "boss%d"))) then
				self.Value:SetText(""..UnitFrames.ShortValue(max).."|r")
			else
				self.Value:SetText(" ")
			end
		end
	end
end

function RobsonUIPostUpdatePower(self, unit, min, max)
	local Parent = self:GetParent()
	local pType, pToken = UnitPowerType(unit)
	local Colors = T["Colors"]
	local Color = Colors.power[pToken]

	if Color then
		self.Value:SetTextColor(1, 1, 1)
	end

	if (not UnitIsPlayer(unit) and not UnitPlayerControlled(unit) or not UnitIsConnected(unit)) then
		self.Value:SetText()
	elseif (UnitIsDead(unit) or UnitIsGhost(unit)) then
		self.Value:SetText()
	else
		if (min ~= max) then
			if (pType == 0) then
				if (unit == "target" or (unit and strfind(unit, "boss%d"))) then
					self.Value:SetFormattedText("%d%% |cffD7BEA5-|r %s", floor(min / max * 100), UnitFrames.ShortValue(max - (max - min)))
				elseif (unit == "player" and Parent:GetAttribute("normalUnit") == "pet" or unit == "pet") then
					self.Value:SetFormattedText("%d%%", floor(min / max * 100))
				elseif (unit and strfind(unit, "arena%d")) or unit == "focus" or unit == "focustarget" then
					self.Value:SetText(UnitFrames.ShortValue(min))
				else
					self.Value:SetFormattedText("%d%% |cffD7BEA5-|r %s", floor(min / max * 100), UnitFrames.ShortValue(max - (max - min)))
				end
			else
				--self.Value:SetFormattedText(""..UnitFrames.ShortValue(max - (max - min).."|r"))
				-- For Demon Hunter, switch!
				self.Value:SetText(max - (max - min))
			end
		else
			if (unit == "pet" or unit == "target" or unit == "focus" or unit == "focustarget" or (unit and strfind(unit, "arena%d")) or (unit and strfind(unit, "boss%d"))) then
				self.Value:SetText(UnitFrames.ShortValue(min))
			else
				self.Value:SetFormattedText(""..UnitFrames.ShortValue(min).."|r")
			end
		end
	end

	if (Parent.Name and unit == "target") then
		UnitFrames.UpdateNamePosition(Parent)
	end
end

local function UpdateBuffsHeaderPosition(self, height)
	local Frame = self:GetParent()
	local Buffs = Frame.Buffs

	if not Buffs then
		return
	end

	Buffs:ClearAllPoints()
	Buffs:Point("BOTTOMLEFT", Frame, "TOPLEFT", -1, 5)
end
hooksecurefunc(UnitFrames, "UpdateBuffsHeaderPosition", UpdateBuffsHeaderPosition)

local function UpdateDebuffsHeaderPosition(self)
	local NumBuffs = self.visibleBuffs
	local PerRow = self.numRow
	local Size = self.size
	local Row = math.ceil((NumBuffs / PerRow))
	local Parent = self:GetParent()
	local Debuffs = Parent.Debuffs
	local Y = Size * Row
	local Addition = Size

	if NumBuffs == 0 then
		Addition = 0
	end

	Debuffs:ClearAllPoints()
	Debuffs:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 0, Y + Addition)
end
hooksecurefunc(UnitFrames, "UpdateDebuffsHeaderPosition", UpdateDebuffsHeaderPosition)

local function RobsoUIPostCreateAura(self, button)
	button:SetBackdrop(nil)
	--button.Shadow:Hide()
	
	button.Remaining = button:CreateFontString(nil, "OVERLAY")
	button.Remaining:SetFont(C.Medias.Font, 12, "THINOUTLINE")
	button.Remaining:Point("CENTER", 1, 0)

	button.cd.noOCC = true
	button.cd.noCooldownCount = true
	button.cd:SetReverse()
	button.cd:SetFrameLevel(button:GetFrameLevel() + 1)
	button.cd:ClearAllPoints()
	button.cd:SetAllPoints()
	button.cd:SetHideCountdownNumbers(true)

	button.icon:SetAllPoints()
	button.icon:SetTexCoord(unpack(T.IconCoord))
	button.icon:SetDrawLayer("ARTWORK")

	button.count:Point("BOTTOMRIGHT", 3, 3)
	button.count:SetJustifyH("RIGHT")
	button.count:SetFont(C.Medias.Font, 9, "THICKOUTLINE")
	button.count:SetTextColor(0.84, 0.75, 0.65)

	button.OverlayFrame = CreateFrame("Frame", nil, button, nil)
	button.OverlayFrame:SetFrameLevel(button.cd:GetFrameLevel() + 1)
	button.overlay:SetParent(button.OverlayFrame)
	button.count:SetParent(button.OverlayFrame)
	button.Remaining:SetParent(button.OverlayFrame)

	button.Animation = button:CreateAnimationGroup()
	button.Animation:SetLooping("BOUNCE")

	button.Animation.FadeOut = button.Animation:CreateAnimation("Alpha")
	button.Animation.FadeOut:SetFromAlpha(1)
	button.Animation.FadeOut:SetToAlpha(0)
	button.Animation.FadeOut:SetDuration(.6)
	button.Animation.FadeOut:SetSmoothing("IN_OUT")
end
hooksecurefunc(UnitFrames, "PostCreateAura", RobsoUIPostCreateAura)

function UnitFrames:GetRaidFramesAttributes()
	local Properties = C.Party.Enable and "custom [@raid6,exists] show;hide" or "solo,party,raid"

	return
		"TukuiRaid",
		nil,
		Properties,
		"oUF-initialConfigFunction", [[
			local header = self:GetParent()
			self:SetWidth(header:GetAttribute("initial-width"))
			self:SetHeight(header:GetAttribute("initial-height"))
		]],
		"initial-width", T.Scale(74),
		"initial-height", T.Scale(32),
		"showParty", true,
		"showRaid", true,
		"showPlayer", true,
		"showSolo", false,
		"xoffset", T.Scale(5),
		"yOffset", T.Scale(-5),
		"point", "LEFT",
		"groupFilter", "1,2,3,4,5,6,7,8",
		"groupingOrder", "1,2,3,4,5,6,7,8",
		"groupBy", C["Raid"].GroupBy.Value,
		"maxColumns", math.ceil(40/5),
		"unitsPerColumn", 5,
		"columnSpacing", T.Scale(5),
		"columnAnchorPoint", "BOTTOM"
end

local function SetGridGroupRole(self)
	local LFDRole = self.LFDRole
	local Role = UnitGroupRolesAssigned(self.unit)

	if Role == "TANK" then
		LFDRole:SetTexture("Interface\\AddOns\\RobsonUI\\Core\\Textures\\tank.tga")
	elseif Role == "HEALER" then
		LFDRole:SetTexture("Interface\\AddOns\\RobsonUI\\Core\\Textures\\healer.tga")
	elseif Role == "DAMAGER" then
		LFDRole:SetTexture("Interface\\AddOns\\RobsonUI\\Core\\Textures\\dps.tga")
	end
end
hooksecurefunc(UnitFrames, "SetGridGroupRole", SetGridGroupRole)

local function CreateUnits()
	local Player = UnitFrames.Units.Player
	local Target = UnitFrames.Units.Target
	local ToT = UnitFrames.Units.TargetOfTarget
	local Pet = UnitFrames.Units.Pet
	local Party = UnitFrames.Headers.Party
	local Raid = UnitFrames.Headers.Raid
	local Boss = UnitFrames.Units.Boss
	
	local Bar2 = T.Panels.ActionBar2
	local Bar3 = T.Panels.ActionBar3
	
	Player:ClearAllPoints()
	Player:SetPoint("BOTTOMLEFT", Bar2, "TOPLEFT", 0, 120)
	Player:Size(235, 44)
	
	Target:ClearAllPoints()
	Target:SetPoint("BOTTOMRIGHT", Bar3, "TOPRIGHT", 0, 120)
	Target:Size(235, 44)
	
	ToT:ClearAllPoints()
	ToT:SetPoint("TOPRIGHT", Target, "BOTTOMRIGHT", 0, -5)
	ToT:Size(100, 22)
	
	Pet:ClearAllPoints()
	Pet:SetPoint("TOPLEFT", Player, "BOTTOMLEFT", -1, -5)
	Pet:Size(100, 22)
	
	if (C.Party.Enable) then
		Party:ClearAllPoints()
		Party:Point("BOTTOMLEFT", ChatBackground, "TOPLEFT", 0, 5)
	end
	
	if (C.Raid.Enable) then
		Raid:ClearAllPoints()
		Raid:SetPoint("BOTTOMLEFT", ChatBackground, "TOPLEFT", 0, 5)
	end
	
	for i = 1, 5 do
		if (i == 1) then
			Boss[i]:ClearAllPoints()
			Boss[i]:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -350, 500)
		else
			Boss[i]:SetPoint("BOTTOM", Boss[i-1], "BOTTOM", 0, -80)             
		end
		Boss[i]:Size(200, 38)
		Boss[i]:SetBackdrop(nil)
	end
end
hooksecurefunc(UnitFrames, "CreateUnits", CreateUnits)