local addonName = ...

local frame = CreateFrame("Frame")

local function tryApply()
    local rxpFrame = _G.RXPFrame
    if not rxpFrame or type(rxpFrame.SetStepFrameAnchor) ~= "function" then
        return false
    end

    local ok = pcall(rxpFrame.SetStepFrameAnchor)
    return ok
end

local applied = false
local function applyOnce()
    if applied then return end
    if tryApply() then
        applied = true
    end
end

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(_, event, arg1)
    if event == "ADDON_LOADED" then
        if arg1 ~= "RXPGuides" and arg1 ~= addonName then
            return
        end
        C_Timer.After(0, applyOnce)
        C_Timer.After(0.5, applyOnce)
        return
    end

    C_Timer.After(0, applyOnce)
end)
