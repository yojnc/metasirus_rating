local addon, ns = ...
local ratingData = ns.RATING_DATA

local COLOR_ASTOUNDING = "|cffe268a8"
local COLOR_LEGENDARY = "|cffff8000"
local COLOR_EPIC = "|cffa335ee"
local COLOR_RARE = "|cff0070ff"
local COLOR_UNCOMMON = "|cff1eff00"
local COLOR_COMMON = "|cffe1e1e1"
local COLOR_MUTED = "|cff9d9d9d"

local function getColorByPercent(percentage)
    if percentage <= 0 then return COLOR_ASTOUNDING end
    if percentage <= 5 then return COLOR_LEGENDARY end
    if percentage <= 15 then return COLOR_EPIC end
    if percentage <= 30 then return COLOR_RARE end
    if percentage <= 80 then return COLOR_UNCOMMON end
    return COLOR_COMMON
end

local function coloredText(text, color)
    return color .. text .. color
end

local function OnTooltipSetUnit(self)
  local unitName, unit = self:GetUnit()
  if not unit then return end
  if not UnitIsPlayer(unit) then return end

  local realm = GetRealmName()
  local text = "н/д"
  local color = COLOR_MUTED
  if ratingData[realm] ~= nil then
    if ratingData[realm][unitName] ~= nil then
        local data = ratingData[realm][unitName]
        color = getColorByPercent(data[2])
        text = data[1]
    end
  end
  GameTooltip:AddDoubleLine("ПВЕ Рейтинг:", coloredText(text, color));
end

GameTooltip:HookScript("OnTooltipSetUnit", OnTooltipSetUnit)
