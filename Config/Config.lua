local T, C, L = Tukui:unpack()

C["ActionBars"]["ShapeShift"] = true
C["ActionBars"]["HideBackdrop"] = false
C["ActionBars"]["HotKey"] = true
C["ActionBars"]["NormalButtonSize"] = 32
C["ActionBars"]["Font"] = "ExpresswayRg"
C["ActionBars"]["ButtonSpacing"] = 1

C["Auras"]["ClassicTimer"] = true
C["Auras"]["Font"] = "ExpresswayRg"

C["Chat"]["Background"] = true
C["Chat"]["WhisperSound"] = false
C["Chat"]["LootFrame"] = false
C["Chat"]["TabFont"] = "ExpresswayRg"
C["Chat"]["ChatFont"] = "ExpresswayRg"

C["Cooldowns"]["Font"] = "ExpresswayRg"

C["DataTexts"]["Battleground"] = false
C["DataTexts"]["Time24HrFormat"] = true
C["DataTexts"]["Font"] = "ExpresswayRg"

C["Merchant"]["AutoSellGrays"] = false

C["Misc"]["ErrorFilterEnable"] = false
C["Misc"]["ExperienceEnable"] = true
C["Misc"]["ThreatBarEnable"] = false
--C["Misc"]["AltPowerBarEnable"] = false

C["Party"]["Enable"] = false
C["Party"]["HealthTexture"] = "Skullflower"
C["Party"]["PowerTexture"] = "Skullflower"
C["Party"]["Font"] = "ExpresswayRg"
C["Party"]["HealthFont"] = "ExpresswayRg"
C["Party"]["Portrait"] = false
C["Party"]["ShowHealthText"] = false

C["Raid"]["ShowPets"] = false
C["Raid"]["Font"] = "ExpresswayRg"
C["Raid"]["ShowHealthText"] = false
C["Raid"]["HealBar"] = false

C["UnitFrames"]["HealthTexture"] = "Skullflower"
C["UnitFrames"]["PowerTexture"] = "Skullflower"
C["UnitFrames"]["CastTexture"] = "Skullflower"
C["UnitFrames"]["Font"] = "ExpresswayRg"
C["UnitFrames"]["AnticipationBar"] = false


------------------------------------------------------------------------
--  Creating an option ...
------------------------------------------------------------------------

C["General"]["TestOption"] = true

-- Supporting locales with your new option, where "enUS" is the locale it is being created for
TukuiConfig["enUS"]["General"]["TestOption"] = {
    ["Name"] = "Some Test Option",
	["Desc"] = "A tooltip about what Test Option does",
}


