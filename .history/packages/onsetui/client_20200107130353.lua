local gui = nil
local infoUIHasBeenShow = nil

local function OnPackageStart() 
    gui = CreateWebUI(0.0, 0.0, 0.0, 0.0, 5, 16)
    LoadWebFile(gui, "http://asset/" .. GetPackageName() .. "/web/index.html")
    SetWebSize(gui, 4000, 2000)
    SetWebAlignment(gui, 0.5, 0.5)
    SetWebAnchors(gui, 0.5, 0.5, 0.5, 0.5)
    SetWebVisibility(gui, WEB_HIDDEN)
    infoUIHasBeenShow = false
end
AddEvent("OnPackageStart", OnPackageStart)

AddEvent("OnKeyPress", function(key)
    if infoUIHasBeenShow == false then
    SetWebVisibility(gui, WEB_HIDDEN)
    CallRemoteEvent('hud:server:show')
    CallRemoteEvent("InfoUI:Show")
        infoUIHasBeenShow = true
    end
    if infoUIHasBeenShow == true then
        
end)
 
AddEvent("OnWebLoadComplete", function(web)
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
