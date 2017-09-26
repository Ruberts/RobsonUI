local T, C, L = Tukui:unpack()

local Chat = T["Chat"]
local Panels = T.Panels
local Noop = function() end
local Toast = BNToastFrame
local ToastCloseButton = BNToastFrameCloseButton

local function StyleFrame(self, frame)
	local Frame = frame
	local ID = frame:GetID()
	local FrameName = frame:GetName()
	local Tab = _G[FrameName.."Tab"]
	local TabText = _G[FrameName.."TabText"]
	local EditBox = _G[FrameName.."EditBox"]
	local GetTabFont = T.GetFont(C["Chat"].TabFont)
	
	TabText:SetTextColor(1, 1, 1)
	TabText.SetTextColor = Noop
	
	EditBox:ClearAllPoints()
	EditBox:SetInside(ChatTabBackground)
	-- Create our own texture for edit box
	EditBox:CreateBackdrop()
	EditBox.Backdrop:ClearAllPoints()
	EditBox.Backdrop:SetAllPoints(ChatTabBackground)
	EditBox.Backdrop:SetFrameStrata("LOW")
	EditBox.Backdrop:SetFrameLevel(1)
	EditBox.Backdrop:SetBackdropColor(unpack(C["General"].BackdropColor))
	

	
end
hooksecurefunc(Chat, "StyleFrame", StyleFrame)

local function SkinToastFrame(self)

	Toast:RobSkin()
	
	-- if C.Chat.Background then
		-- Toast:Point("BOTTOMLEFT", ChatBackground, "TOPLEFT", 100, 5)
	-- else
		-- Toast:Point("BOTTOMLEFT", ChatFrame1, "TOPLEFT", 0, 5)
	-- end
	Toast:ClearAllPoints()
	Toast:SetPoint("BOTTOMLEFT", ChatBackground, "TOPLEFT", 0, 5)

end
hooksecurefunc(Chat, "SkinToastFrame", SkinToastFrame)

local function SetDefaultChatFramesPositions()
	if (not TukuiData[GetRealmName()][UnitName("Player")].Chat) then
		TukuiData[GetRealmName()][UnitName("Player")].Chat = {}
	end

	for i = 1, NUM_CHAT_WINDOWS do
		local Frame = _G["ChatFrame"..i]
		local ID = Frame:GetID()
		
		local Width = ChatBackground:GetWidth() - 4
		local Height = ChatBackground:GetHeight() - 26

		-- Set font size and chat frame size
		Frame:Size(Width, Height)

		-- Set default chat frame position
		if (ID == 1) then
			Frame:ClearAllPoints()
			Frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 2, 2)
			Frame:RobSkin()
		elseif (ID == 2) then
			Frame:ClearAllPoints()
			Frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 2, 2)
		elseif (ID == 3) then
			Frame:ClearAllPoints()
			Frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 2, 2)
		elseif (ID == 4) then 
			Frame:ClearAllPoints()
			Frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 2, 2)
		elseif (C.Chat.LootFrame and ID == 4) then
			if (not Frame.isDocked) then
				Frame:ClearAllPoints()
				Frame:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -44, 50)
			end
		end

		if (ID == 1) then
			FCF_SetWindowName(Frame, "General")
		elseif (ID == 2) then
			FCF_SetWindowName(Frame, "Combat")
		elseif (ID == 3) then
			FCF_SetWindowName(Frame, "Whisper")
		elseif (ID == 4) then
			FCF_SetWindowName(Frame, "Loot")
		end

		if (not Frame.isLocked) then
			FCF_SetLocked(Frame, 1)
		end
		

		local Anchor1, Parent, Anchor2, X, Y = Frame:GetPoint()
		TukuiData[GetRealmName()][UnitName("Player")].Chat["Frame" .. i] = {Anchor1, Anchor2, X, Y, Width, Height}
	end
end
hooksecurefunc(Chat, "SetDefaultChatFramesPositions", SetDefaultChatFramesPositions)

local function SaveChatFramePositionAndDimensions(self)
	local Anchor1, _, Anchor2, X, Y = self:GetPoint()
	local Width, Height = self:GetSize()
	local ID = self:GetID()

	if not (TukuiData[GetRealmName()][UnitName("Player")].Chat) then
		TukuiData[GetRealmName()][UnitName("Player")].Chat = {}
	end

	TukuiData[GetRealmName()][UnitName("Player")].Chat["Frame" .. ID] = {Anchor1, Anchor2, X, Y, Width, Height}
end
hooksecurefunc(Chat, "SaveChatFramePositionAndDimensions", SaveChatFramePositionAndDimensions)

local function SetChatPosition(self)
	if (not TukuiData[GetRealmName()][UnitName("Player")].Chat) then
		return
	end

	local Frame = self

	if not Frame:IsMovable() then
		return
	end

	local ID = Frame:GetID()
	local Settings = TukuiData[GetRealmName()][UnitName("Player")].Chat["Frame" .. ID]

	if Settings then
		local Anchor1, Anchor2, X, Y, Width, Height = unpack(Settings)

		Frame:SetUserPlaced(true)
		Frame:ClearAllPoints()
		Frame:SetPoint(Anchor1, ChatBackground, Anchor2, X, Y)
		Frame:SetSize(Width, Height)
	end

	if (not C.Chat.LootFrame) then
		if (FCF_GetChatWindowInfo(ID) == LOOT) then
			FCF_Close(Frame)
		end
	end
end
hooksecurefunc(Chat, "SetChatFramePosition", SetChatPosition)

local function RobsonInstall(self)
	-- Create our custom chatframes
	FCF_ResetChatWindows()
	FCF_UnDockFrame(ChatFrame1)
	FCF_SetLocked(ChatFrame1, 1)
	
	FCF_SetLocked(ChatFrame2, 1)

	FCF_OpenNewWindow(Loot)
	FCF_SetLocked(ChatFrame3, 1)

	FCF_OpenNewWindow(Trade)
	FCF_SetLocked(ChatFrame4, 1)


	if C.Chat.LootFrame then
		FCF_OpenNewWindow(LOOT)
		FCF_UnDockFrame(ChatFrame4)
		ChatFrame4:Show()
	end

	-- Set more chat groups
	ChatFrame_RemoveAllMessageGroups(ChatFrame1)
	ChatFrame_RemoveChannel(ChatFrame1, TRADE)
	ChatFrame_RemoveChannel(ChatFrame1, GENERAL)
	ChatFrame_RemoveChannel(ChatFrame1, L.ChatFrames.LocalDefense)
	ChatFrame_RemoveChannel(ChatFrame1, L.ChatFrames.GuildRecruitment)
	ChatFrame_RemoveChannel(ChatFrame1, L.ChatFrames.LookingForGroup)
	ChatFrame_AddChannel(ChatFrame1, GENERAL)
	ChatFrame_AddMessageGroup(ChatFrame1, "SAY")
	ChatFrame_AddMessageGroup(ChatFrame1, "EMOTE")
	ChatFrame_AddMessageGroup(ChatFrame1, "YELL")
	ChatFrame_AddMessageGroup(ChatFrame1, "GUILD")
	ChatFrame_AddMessageGroup(ChatFrame1, "OFFICER")
	ChatFrame_AddMessageGroup(ChatFrame1, "GUILD_ACHIEVEMENT")
	ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_SAY")
	ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_EMOTE")
	ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_YELL")
	ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_WHISPER")
	ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_BOSS_EMOTE")
	ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_BOSS_WHISPER")
	ChatFrame_AddMessageGroup(ChatFrame1, "PARTY")
	ChatFrame_AddMessageGroup(ChatFrame1, "PARTY_LEADER")
	ChatFrame_AddMessageGroup(ChatFrame1, "RAID")
	ChatFrame_AddMessageGroup(ChatFrame1, "RAID_LEADER")
	ChatFrame_AddMessageGroup(ChatFrame1, "RAID_WARNING")
	ChatFrame_AddMessageGroup(ChatFrame1, "INSTANCE_CHAT")
	ChatFrame_AddMessageGroup(ChatFrame1, "INSTANCE_CHAT_LEADER")
	ChatFrame_AddMessageGroup(ChatFrame1, "BG_HORDE")
	ChatFrame_AddMessageGroup(ChatFrame1, "BG_ALLIANCE")
	ChatFrame_AddMessageGroup(ChatFrame1, "BG_NEUTRAL")
	ChatFrame_AddMessageGroup(ChatFrame1, "SYSTEM")
	ChatFrame_AddMessageGroup(ChatFrame1, "ERRORS")
	ChatFrame_AddMessageGroup(ChatFrame1, "AFK")
	ChatFrame_AddMessageGroup(ChatFrame1, "DND")
	ChatFrame_AddMessageGroup(ChatFrame1, "IGNORED")
	ChatFrame_AddMessageGroup(ChatFrame1, "ACHIEVEMENT")
	ChatFrame_AddMessageGroup(ChatFrame1, "CURRENCY")
	ChatFrame_AddMessageGroup(ChatFrame1, "SKILL")
	ChatFrame_AddMessageGroup(ChatFrame1, "COMBAT_FACTION_CHANGE")

	-- Setup the Whisper chat
	ChatFrame_RemoveAllMessageGroups(ChatFrame3)
	ChatFrame_AddMessageGroup(ChatFrame3, "WHISPER")
	ChatFrame_AddMessageGroup(ChatFrame3, "BN_WHISPER")
	ChatFrame_AddMessageGroup(ChatFrame3, "BN_CONVERSATION")
	
	-- Setup the Loot chat
	ChatFrame_RemoveAllMessageGroups(ChatFrame4)
	ChatFrame_AddChannel(ChatFrame4, TRADE)
	ChatFrame_AddMessageGroup(ChatFrame4, "COMBAT_XP_GAIN")
	ChatFrame_AddMessageGroup(ChatFrame4, "COMBAT_HONOR_GAIN")
	ChatFrame_AddMessageGroup(ChatFrame4, "LOOT")
	ChatFrame_AddMessageGroup(ChatFrame4, "MONEY")	

	-- Setup the right chat
	if C.Chat.LootFrame then
		ChatFrame_RemoveAllMessageGroups(ChatFrame4)
		ChatFrame_AddMessageGroup(ChatFrame4, "COMBAT_XP_GAIN")
		ChatFrame_AddMessageGroup(ChatFrame4, "COMBAT_HONOR_GAIN")
		ChatFrame_AddMessageGroup(ChatFrame4, "COMBAT_FACTION_CHANGE")
		ChatFrame_AddMessageGroup(ChatFrame4, "LOOT")
		ChatFrame_AddMessageGroup(ChatFrame4, "MONEY")
	end

	-- Enable Classcolor
	ToggleChatColorNamesByClassGroup(true, "SAY")
	ToggleChatColorNamesByClassGroup(true, "EMOTE")
	ToggleChatColorNamesByClassGroup(true, "YELL")
	ToggleChatColorNamesByClassGroup(true, "GUILD")
	ToggleChatColorNamesByClassGroup(true, "OFFICER")
	ToggleChatColorNamesByClassGroup(true, "GUILD_ACHIEVEMENT")
	ToggleChatColorNamesByClassGroup(true, "ACHIEVEMENT")
	ToggleChatColorNamesByClassGroup(true, "WHISPER")
	ToggleChatColorNamesByClassGroup(true, "PARTY")
	ToggleChatColorNamesByClassGroup(true, "PARTY_LEADER")
	ToggleChatColorNamesByClassGroup(true, "RAID")
	ToggleChatColorNamesByClassGroup(true, "RAID_LEADER")
	ToggleChatColorNamesByClassGroup(true, "RAID_WARNING")
	ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND")
	ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND_LEADER")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL1")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL2")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL3")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL4")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL5")
	ToggleChatColorNamesByClassGroup(true, "INSTANCE_CHAT")
	ToggleChatColorNamesByClassGroup(true, "INSTANCE_CHAT_LEADER")

	DEFAULT_CHAT_FRAME:SetUserPlaced(true)

	self:SetDefaultChatFramesPositions()
end
hooksecurefunc(Chat, "Install", RobsonInstall)