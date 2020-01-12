local gui = nil
local infoUIHasBeenShow = false
local startScreenLoaded = false

local function OnPackageStart() 
    gui = CreateWebUI(0.0, 0.0, 0.0, 0.0, 5, 16)
    LoadWebFile(gui, "http://asset/" .. GetPackageName() .. "/web/index.html")
    SetWebSize(gui, 4000, 2000)
    SetWebAlignment(gui, 0.5, 0.5)
    SetWebAnchors(gui, 0.5, 0.5, 0.5, 0.5)
    SetWebVisibility(gui, WEB_HIDDEN)
    SetIgnoreMoveInput(true)
    StartCameraFade(1.0, 1.0, 3.0, RGB(0, 0, 0))
    CallRemoteEvent("SetUIOpenStatus", true)
end
AddEvent("OnPackageStart", OnPackageStart)

AddEvent("OnKeyPress", function(key)
    if infoUIHasBeenShow == false and startScreenLoaded then
        SetWebVisibility(gui, WEB_HIDDEN)
        CallRemoteEvent('hud:server:show')
        CallRemoteEvent("InfoUI:Show")
        infoUIHasBeenShow = true
    end
end)
 
AddEvent("OnWebLoadComplete", function(web)
    if web == gui then
        startScreenLoaded = true
        CallRemoteEvent("GetStartScreenData")
    end
end)

local function showgui(message, playername)
    ExecuteWebJS(gui, "updateText('" .. message .. "');")
    ExecuteWebJS(gui, "updateName('" .. playername .. "');")
    SetWebVisibility(gui, WEB_HITINVISIBLE)
end
AddRemoteEvent("motd:show", showgui)	
