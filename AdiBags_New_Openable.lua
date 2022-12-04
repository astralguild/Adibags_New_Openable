local AdiBags = LibStub("AceAddon-3.0"):GetAddon("AdiBags")
 
local OPENABLE = "Openable"
local OPENABLE_CATEGORY_TITLE = '|cff2beefd'..OPENABLE
local LOCKBOXES_CATEGORY_TITLE = '|cff2beefd'..'Lockboxes'
local OPENABLE_DESCRIPTION = "Filter items that which can be right clicked to open."
local OPENABLE_CONTAINER = "Open the container"
local OPENABLE_USEOPEN = "Use: Open"
 
 
local mod = AdiBags:RegisterFilter("Openable", 90, "ABEvent-1.0")
mod.uiName = OPENABLE
mod.uiDesc = OPENABLE_DESCRIPTION
 
function mod:OnInitialize()
    AdiBags:SetCategoryOrder(OPENABLE_CATEGORY_TITLE, 90)
    AdiBags:SetCategoryOrder(LOCKBOXES_CATEGORY_TITLE, 89)
end
 
function mod:Filter(slotData)
    local tooltipInfo
 
    if slotData.bag == BANK_CONTAINER then
        tooltipInfo = C_TooltipInfo.GetInventoryItem("player", BankButtonIDToInvSlotID(slotData.slot, nil))
    else
        tooltipInfo = C_TooltipInfo.GetBagItem(slotData.bag, slotData.slot)
    end
 
    TooltipUtil.SurfaceArgs(tooltipInfo)
    for _, line in ipairs(tooltipInfo.lines) do
        TooltipUtil.SurfaceArgs(line)
    end
 
    for _, line in ipairs(tooltipInfo.lines) do
        local t = line.leftText
        if t then
            if t == ITEM_OPENABLE or string.find(t, OPENABLE_CONTAINER) or string.find(t, OPENABLE_USEOPEN) then
                return OPENABLE_CATEGORY_TITLE
            elseif t == LOCKED then
                return LOCKBOXES_CATEGORY_TITLE
            end
        end
    end
end
