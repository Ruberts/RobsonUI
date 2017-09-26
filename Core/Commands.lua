local T, C, L = Tukui:unpack()

------------------------------------------------------------------------
--  I want to add 2 new / commands to Tukui, so ...
------------------------------------------------------------------------

local Commands = T.AddOnCommands

local function hihi()
	print("My chat is lol'ing at you")
end

local function hideui()
	ToggleFrame(UIParent)
end

-- these are the new commands: /tukui hihi & /tukui hideui
Commands["hihi"] = hihi
Commands["hideui"] = hideui