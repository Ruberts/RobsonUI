local T, C, L = Tukui:unpack()

local function CreateOverlay(frame)
	if(frame.overlay) then return end

	local overlay = frame:CreateTexture(frame:GetName() and frame:GetName() .. "Overlay" or nil, "BORDER", frame)
	overlay:ClearAllPoints()
	overlay:Point("TOPLEFT", 0, 0)
	overlay:Point("BOTTOMRIGHT", 0, 0)
	overlay:SetTexture([[Interface\AddOns\RobsonUI\Core\Textures\Skullflower.tga]])
	overlay:SetVertexColor(0.3, 0.3, 0.3, 1)
	frame.overlay = overlay
end

local function CreateBorder(f, i, o)
	if i then
		if f.iborder then return end
		local border = CreateFrame("Frame", f:GetName() and f:GetName() .. "InnerBorder" or nil, f)
		border:Point("TOPLEFT", T.Mult, -T.Mult)
		border:Point("BOTTOMRIGHT", -T.Mult, T.Mult)
		border:SetBackdrop({
			edgeFile = C.Medias.Blank, 
			edgeSize = T.Mult, 
			insets = { left = T.Mult, right = T.Mult, top = T.Mult, bottom = T.Mult }
		})
		border:SetBackdropBorderColor(0, 0, 0)
		f.iborder = border
	end
	
	if o then
		if f.oborder then return end
		local border = CreateFrame("Frame", f:GetName() and f:GetName() .. "OuterBorder" or nil, f)
		border:Point("TOPLEFT", -T.Mult, T.Mult)
		border:Point("BOTTOMRIGHT", T.Mult, -T.Mult)
		border:SetFrameLevel(f:GetFrameLevel())
		border:SetBackdrop({
			edgeFile = C.Medias.Blank, 
			edgeSize = T.Mult, 
			insets = { left = T.Mult, right = T.Mult, top = T.Mult, bottom = T.Mult }
		})
		border:SetBackdropBorderColor(0, 0, 0)
		f.oborder = border
	end
end

local function RobSkin(f)
	f:SetTemplate("Transparent")
	CreateBorder(f, false, true)
	f:HideInsets()
	f:SetBackdropBorderColor(0, 0, 0, 0)
end

local function RobSkin2(f)
	f:SetTemplate("Transparent")
	CreateBorder(f, true, false)
	f:HideInsets()
	f:SetBackdropBorderColor(0, 0, 0, 0)
end

local function rCreateBackdrop(f, t, tex)
	if f.Backdrop then return end
	if not t then t = "Default" end
	
	local b = CreateFrame("Frame", nil, f)
	b:SetAllPoints()
	b:RobSkin()
	
	if f:GetFrameLevel() - 1 >= 0 then
		b:SetFrameLevel(f:GetFrameLevel() - 1)
	else
		b:SetFrameLevel(0)
	end

	f.Backdrop = b
end

local function SkinFrame2px(f, t, tex)
	local balpha = 1
	if t == "Transparent" then balpha = 0.8 end
	local borderr, borderg, borderb = unpack(C.General.BorderColor)
	--local borderr, borderg, borderb = {0, 0, 0, 1}
	local backdropr, backdropg, backdropb = unpack(C.General.BackdropColor)
	local backdropa = balpha
	local texture = C.Medias.Blank

	if tex then
		texture = C.Medias.Normal
	end

	f:SetBackdrop({
	  bgFile = texture,
	  edgeFile = false, tile = false, tileSize = 0, edgeSize = T.Mult,
	 -- insets = { left = -1, right = -1, top = -1, bottom = -1 }
	})

	if not f.isInsetDone then
		f.insettop = f:CreateTexture(nil, "BORDER")
		f.insettop:Point("TOPLEFT", f, "TOPLEFT", -2, 2)
		f.insettop:Point("TOPRIGHT", f, "TOPRIGHT", 2, -2)
		f.insettop:Height(2)
		f.insettop:SetColorTexture(0,0,0)
		f.insettop:SetDrawLayer("BORDER", -7)

		f.insetbottom = f:CreateTexture(nil, "BORDER")
		f.insetbottom:Point("BOTTOMLEFT", f, "BOTTOMLEFT", -2, -2)
		f.insetbottom:Point("BOTTOMRIGHT", f, "BOTTOMRIGHT", 2, -2)
		f.insetbottom:Height(2)
		f.insetbottom:SetColorTexture(0,0,0)
		f.insetbottom:SetDrawLayer("BORDER", -7)

		f.insetleft = f:CreateTexture(nil, "BORDER")
		f.insetleft:Point("TOPLEFT", f, "TOPLEFT", -2, 2)
		f.insetleft:Point("BOTTOMLEFT", f, "BOTTOMLEFT", 2, -2)
		f.insetleft:Width(2)
		f.insetleft:SetColorTexture(0,0,0)
		f.insetleft:SetDrawLayer("BORDER", -7)

		f.insetright = f:CreateTexture(nil, "BORDER")
		f.insetright:Point("TOPRIGHT", f, "TOPRIGHT", 2, 2)
		f.insetright:Point("BOTTOMRIGHT", f, "BOTTOMRIGHT", -2, -2)
		f.insetright:Width(2)
		f.insetright:SetColorTexture(0,0,0)
		f.insetright:SetDrawLayer("BORDER", -7)

		-- f.insetinsidetop = f:CreateTexture(nil, "BORDER")
		-- f.insetinsidetop:Point("TOPLEFT", f, "TOPLEFT", 1, -1)
		-- f.insetinsidetop:Point("TOPRIGHT", f, "TOPRIGHT", -1, 1)
		-- f.insetinsidetop:Height(1)
		-- f.insetinsidetop:SetColorTexture(0,0,0)
		-- f.insetinsidetop:SetDrawLayer("BORDER", -7)

		-- f.insetinsidebottom = f:CreateTexture(nil, "BORDER")
		-- f.insetinsidebottom:Point("BOTTOMLEFT", f, "BOTTOMLEFT", 1, 1)
		-- f.insetinsidebottom:Point("BOTTOMRIGHT", f, "BOTTOMRIGHT", -1, 1)
		-- f.insetinsidebottom:Height(1)
		-- f.insetinsidebottom:SetColorTexture(0,0,0)
		-- f.insetinsidebottom:SetDrawLayer("BORDER", -7)

		-- f.insetinsideleft = f:CreateTexture(nil, "BORDER")
		-- f.insetinsideleft:Point("TOPLEFT", f, "TOPLEFT", 1, -1)
		-- f.insetinsideleft:Point("BOTTOMLEFT", f, "BOTTOMLEFT", -1, 1)
		-- f.insetinsideleft:Width(1)
		-- f.insetinsideleft:SetColorTexture(0,0,0)
		-- f.insetinsideleft:SetDrawLayer("BORDER", -7)

		-- f.insetinsideright = f:CreateTexture(nil, "BORDER")
		-- f.insetinsideright:Point("TOPRIGHT", f, "TOPRIGHT", -1, -1)
		-- f.insetinsideright:Point("BOTTOMRIGHT", f, "BOTTOMRIGHT", 1, 1)
		-- f.insetinsideright:Width(1)
		-- f.insetinsideright:SetColorTexture(0,0,0)
		-- f.insetinsideright:SetDrawLayer("BORDER", -7)

		f.isInsetDone = true
	end

	f:SetBackdropColor(backdropr, backdropg, backdropb, backdropa)
	f:SetBackdropBorderColor(borderr, borderg, borderb)
end


local function rSkinFrame(f, t, tex)
	local balpha = 1
	if t == "Transparent" then balpha = 0.8 end
	local borderr, borderg, borderb = unpack(C.General.BorderColor)
	--local borderr, borderg, borderb = {0, 0, 0, 1}
	local backdropr, backdropg, backdropb = unpack(C.General.BackdropColor)
	local backdropa = balpha
	local texture = C.Medias.Blank

	if tex then
		texture = C.Medias.Normal
	end

	f:SetBackdrop({
	  bgFile = texture,
	  edgeFile = false, tile = false, tileSize = 0, edgeSize = T.Mult,
	  insets = { left = -1, right = -1, top = -1, bottom = -1 }
	})

	if not f.isInsetDone then
		-- f.insettop = f:CreateTexture(nil, "BORDER")
		-- f.insettop:Point("TOPLEFT", f, "TOPLEFT", -1, 1)
		-- f.insettop:Point("TOPRIGHT", f, "TOPRIGHT", 1, -1)
		-- f.insettop:Height(1)
		-- f.insettop:SetColorTexture(0,0,0)
		-- f.insettop:SetDrawLayer("BORDER", -7)

		-- f.insetbottom = f:CreateTexture(nil, "BORDER")
		-- f.insetbottom:Point("BOTTOMLEFT", f, "BOTTOMLEFT", -1, -1)
		-- f.insetbottom:Point("BOTTOMRIGHT", f, "BOTTOMRIGHT", 1, -1)
		-- f.insetbottom:Height(1)
		-- f.insetbottom:SetColorTexture(0,0,0)
		-- f.insetbottom:SetDrawLayer("BORDER", -7)

		-- f.insetleft = f:CreateTexture(nil, "BORDER")
		-- f.insetleft:Point("TOPLEFT", f, "TOPLEFT", -1, 1)
		-- f.insetleft:Point("BOTTOMLEFT", f, "BOTTOMLEFT", 1, -1)
		-- f.insetleft:Width(12)
		-- f.insetleft:SetColorTexture(0,0,0)
		-- f.insetleft:SetDrawLayer("BORDER", -7)

		-- f.insetright = f:CreateTexture(nil, "BORDER")
		-- f.insetright:Point("TOPRIGHT", f, "TOPRIGHT", 1, 1)
		-- f.insetright:Point("BOTTOMRIGHT", f, "BOTTOMRIGHT", -1, -1)
		-- f.insetright:Width(1)
		-- f.insetright:SetColorTexture(0,0,0)
		-- f.insetright:SetDrawLayer("BORDER", -7)

		-- f.insetinsidetop = f:CreateTexture(nil, "BORDER")
		-- f.insetinsidetop:Point("TOPLEFT", f, "TOPLEFT", 1, -1)
		-- f.insetinsidetop:Point("TOPRIGHT", f, "TOPRIGHT", -1, 1)
		-- f.insetinsidetop:Height(1)
		-- f.insetinsidetop:SetColorTexture(0,0,0)
		-- f.insetinsidetop:SetDrawLayer("BORDER", -7)

		-- f.insetinsidebottom = f:CreateTexture(nil, "BORDER")
		-- f.insetinsidebottom:Point("BOTTOMLEFT", f, "BOTTOMLEFT", 1, 1)
		-- f.insetinsidebottom:Point("BOTTOMRIGHT", f, "BOTTOMRIGHT", -1, 1)
		-- f.insetinsidebottom:Height(1)
		-- f.insetinsidebottom:SetColorTexture(0,0,0)
		-- f.insetinsidebottom:SetDrawLayer("BORDER", -7)

		-- f.insetinsideleft = f:CreateTexture(nil, "BORDER")
		-- f.insetinsideleft:Point("TOPLEFT", f, "TOPLEFT", 1, -1)
		-- f.insetinsideleft:Point("BOTTOMLEFT", f, "BOTTOMLEFT", -1, 1)
		-- f.insetinsideleft:Width(1)
		-- f.insetinsideleft:SetColorTexture(0,0,0)
		-- f.insetinsideleft:SetDrawLayer("BORDER", -7)

		-- f.insetinsideright = f:CreateTexture(nil, "BORDER")
		-- f.insetinsideright:Point("TOPRIGHT", f, "TOPRIGHT", -1, -1)
		-- f.insetinsideright:Point("BOTTOMRIGHT", f, "BOTTOMRIGHT", 1, 1)
		-- f.insetinsideright:Width(1)
		-- f.insetinsideright:SetColorTexture(0,0,0)
		-- f.insetinsideright:SetDrawLayer("BORDER", -7)

		f.isInsetDone = true
	end

	f:SetBackdropColor(backdropr, backdropg, backdropb, backdropa)
	f:SetBackdropBorderColor(borderr, borderg, borderb)
end

local function rStyleButton(button)

	if button.SetHighlightTexture and not button.hover then
		local hover = button:CreateTexture()
		hover:SetColorTexture(1, 1, 1, 0.3)
		--hover:SetInside()
		hover:SetAllPoints()
		button.hover = hover
		button:SetHighlightTexture(hover)
	end

	if button.SetPushedTexture and not button.pushed then
		local pushed = button:CreateTexture()
		pushed:SetColorTexture(0.9, 0.8, 0.1, 0.3)
		pushed:SetInside()
		button.pushed = pushed
		button:SetPushedTexture(pushed)
	end

	if button.SetCheckedTexture and not button.checked then
		local checked = button:CreateTexture()
		checked:SetColorTexture(0,1,0,.3)
		checked:SetInside()
		button.checked = checked
		button:SetCheckedTexture(checked)
	end

	local cooldown = button:GetName() and _G[button:GetName().."Cooldown"]
	if cooldown then
		cooldown:ClearAllPoints()
		--cooldown:SetInside()
		cooldown:SetAllPoints()
	end
end

local function addapi(object)
	local mt = getmetatable(object).__index
	if not object.CreateOverlay then mt.CreateOverlay= CreateOverlay end
	if not object.CreateBorder then mt.CreateBorder = CreateBorder end
	if not object.RobSkin then mt.RobSkin = RobSkin end
	if not object.RobSkin2 then mt.RobSkin2 = RobSkin2 end
	if not object.SkinFrame2px then mt.SkinFrame2px = SkinFrame2px end
	if not object.rSkinFrame then mt.rSkinFrame = rSkinFrame end
	if not object.rStyleButton then mt.rStyleButton = rStyleButton end
	if not object.rCreateBackdrop then mt.rCreateBackdrop = rCreateBackdrop end
end

local handled = {["Frame"] = true}
local object = CreateFrame("Frame")
addapi(object)
addapi(object:CreateTexture())
addapi(object:CreateFontString())


object = EnumerateFrames()
while object do
	if(not handled[object:GetObjectType()]) then
		addapi(object)
		handled[object:GetObjectType()] = true
	end

	object = EnumerateFrames(object)
end