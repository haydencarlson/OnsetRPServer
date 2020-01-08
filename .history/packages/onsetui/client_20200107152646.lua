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
end
AddEvent("OnPackageStart", OnPackageStart)

AddEvent("OnKeyPress", function(key)
    if infoUIHasBeenShow == false and startScreenLoaded then
    SetWebVisibility(gui, WEB_HIDDEN)
    CallRemoteEvent('hud:server:show')
    CallRemoteEvent("InfoUI:Show")
       SetInputMode(INPUT_GAMEDUI) 
       infoUIHasBeenShow = true
        
    end
end)
 
AddEvent("OnWebLoadComplete", function(web)
    startScreenLoaded = true
    if web == gui then
        CallRemoteEvent("GetStartScreenData")
    end
end)

local function showgui(message, playername)
    ExecuteWebJS(gui, "updateText('" .. message .. "');")
    ExecuteWebJS(gui, "updateName('" .. playername .. "');")
    SetWebVisibility(gui, WEB_HITINVISIBLE)
end
AddRemoteEvent("motd:show", showgui)	
