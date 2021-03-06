﻿local T, C, L = Tukui:unpack()

local Cooldowns = T["Cooldowns"]

local function UpdateCooldown(self)
	local Enabled = GetCVar("countdownForCooldowns")

	if (Enabled) then
		if not self.IsCooldownTextEdited then
			local NumRegions = self:GetNumRegions()

			for i = 1, NumRegions do
				local Region = select(i, self:GetRegions())

				if Region.GetText then
					local Font = T.GetFont(C["Cooldowns"].Font)
					Font = _G[Font]:GetFont()

					Region:SetFont(Font, 14, "OUTLINE")
					Region:Point("CENTER", 1, 0)
					Region:SetTextColor(1, 1, 1)
				end
			end

			self.IsCooldownTextEdited = true
		end
	end
end
hooksecurefunc("CooldownFrame_Set", UpdateCooldown)