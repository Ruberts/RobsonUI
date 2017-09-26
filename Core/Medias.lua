local T, C, L = Tukui:unpack()

if not C["Medias"] then C["Medias"] = {} end

C["Medias"]["Font"] = [=[Interface\AddOns\RobsonUI\Core\Fonts\ExpresswayRg.ttf]=]
-- C["Medias"]["UnitFrameFont"] = [=[Interface\AddOns\RobsonUI\Core\Fonts\Prototype.ttf]=]
-- C["Medias"]["DamageFont"] = [=[Interface\AddOns\RobsonUI\Core\Fonts\MyriadProSemibold.ttf]=]
-- C["Medias"]["PixelFont"] = [=[Interface\AddOns\RobsonUI\Core\Fonts\Visitor2.ttf]=]
-- C["Medias"]["ActionBarFont"] = [=[Interface\AddOns\RobsonUI\Core\Fonts\Prototype.ttf]=]

-- Registering new media with Tukui
TukuiMedia = T["Media"]

local Prototype = CreateFont("Prototype")
Prototype:SetFont("Interface\\AddOns\\RobsonUI\\Core\\Fonts\\Prototype.ttf", 12, "THINOUTLINE")
Prototype:SetShadowColor(0, 0, 0)
Prototype:SetShadowOffset(0, 0)
TukuiMedia:RegisterFont("Prototype", "Prototype")

local ExpresswayRg = CreateFont("ExpresswayRg")
ExpresswayRg:SetFont("Interface\\AddOns\\RobsonUI\\Core\\Fonts\\ExpresswayRg.ttf", 12, "THINOUTLINE")
ExpresswayRg:SetShadowColor(0, 0, 0)
ExpresswayRg:SetShadowOffset(0, 0)
TukuiMedia:RegisterFont("ExpresswayRg", "ExpresswayRg")

local HealthFont = CreateFont("HealthFont")
HealthFont:SetFont("Interface\\AddOns\\RobsonUI\\Core\\Fonts\\ExpresswayRg.ttf", 17, "THINOUTLINE")
HealthFont:SetShadowColor(0, 0, 0)
HealthFont:SetShadowOffset(0, 0)
TukuiMedia:RegisterFont("HealthFont", "HealthFont")

TukuiMedia:RegisterTexture("Skullflower", "Interface\\AddOns\\RobsonUI\\Core\\Textures\\Skullflower.tga")

-- local FontObject = CreateFont("TestFont")
-- FontObject:SetFont(C["Medias"].Font, 12)

-- First argument is the name as it will appear in the config, the second argument
-- is the name of your newly created font object
-- TukuiMedia:RegisterFont("Test Font", "TestFont")

-- First argument is the name as it will appear in the config, the second argument
-- is a file path to your texture
--TukuiMedia:RegisterTexture("Blah", "Interface\\BUTTONS\\WHITE8X8.tga")