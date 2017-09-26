local T, C, L = Tukui:unpack()

-- Credit to Merathilis @ Tukui.org for the skinning

local pairs, select, unpack = pairs, select, unpack

local CreateFrame = CreateFrame
local IsAddOnLoaded = IsAddOnLoaded
local Noop = function() return end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event)
	if not IsAddOnLoaded("WeakAuras") then return end
	
	local function SkinWeakAuras(frame, ftype)
		if ftype == "icon" then
			if not frame.backdrop then
				frame:rCreateBackdrop(frame, "Transparent")
				frame.Backdrop:CreateShadow()
				frame.Backdrop:HookScript("OnUpdate", function(self)
					self:SetAlpha(self:GetParent().icon:GetAlpha())
				end)
				frame.icon:SetTexCoord(unpack(T.IconCoord))
				frame.icon.SetTexCoord = Noop
			end
		end
		
		if ftype == "aurabar" then
			if not frame.bar.shadow then
				frame.bar:CreateShadow("Background")
				frame.iconFrame:CreateShadow("Background")
				frame.iconFrame:SetAllPoints(frame.icon)
				frame.icon:SetTexCoord(unpack(T.IconCoord))
				frame.icon.SetTexCoord = Noop
				
				hooksecurefunc(frame.bar, "SetForegroundColor", function(self, r, g, b, a)
					self.fg:SetGradient("VERTICAL", T.ColorGradient(r, g, b))
				end)
				
				hooksecurefunc(frame.bar, "SetBackgroundColor", function(self, r, g, b, a)
					self.bg:SetGradient("VERTICAL", T.ColorGradient(r, g, b))
				end)
			end
		end
	end
	
	local CreateIcon = WeakAuras.regionTypes.icon.create
	WeakAuras.regionTypes.icon.create = function(parent, data)
		local region = CreateIcon(parent, data)
		SkinWeakAuras(region, "icon")
		return region
	end

	local ModifyIcon = WeakAuras.regionTypes.icon.modify
	WeakAuras.regionTypes.icon.modify = function(parent, region, data)
		ModifyIcon(parent, region, data)
		SkinWeakAuras(region, "icon")
	end

	local CreateAuraBar = WeakAuras.regionTypes.aurabar.create
	WeakAuras.regionTypes.aurabar.create = function(parent)
		local region = CreateAuraBar(parent)
		SkinWeakAuras(region, "aurabar")
		return region
	end

	local ModifyAuraBar = WeakAuras.regionTypes.aurabar.modify
	WeakAuras.regionTypes.aurabar.modify = function(parent, region, data)
		ModifyAuraBar(parent, region, data)
		SkinWeakAuras(region, "aurabar")
	end

	for aura, _ in pairs(WeakAuras.regions) do
		local ftype = WeakAuras.regions[aura].regionType

		if ftype == "icon" or ftype == "aurabar" then
			SkinWeakAuras(WeakAuras.regions[aura].region, ftype)
		end
	end
end)