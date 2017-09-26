local T, C, L = Tukui:unpack()

if not IsAddOnsLoaded ("ls_Toasts") then return end

local LST = unpack(ls_Toasts)

function LST:SkinToast(toast, toastType)
	toast.