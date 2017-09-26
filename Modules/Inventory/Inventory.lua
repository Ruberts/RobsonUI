local T, C, L = Tukui:unpack()

local BagFilter = T["Inventory"].BagFilter

BagFilter:AddItem(37704) -- Add 'Crystallized Life' to the bag filter
BagFilter:RemoveItem(32897) -- Remove 'Mark of the Illidari' from the defaults