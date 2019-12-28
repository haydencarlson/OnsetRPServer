local gui = nil

local function OnPackageStart() 
    gui = CreateWebUI(0.0, 0.0, 0.0, 0.0, 5, 16)
    LoadWebFile(gui, "http://asset/" .. GetPackageName() .. "/web/index.html")
    SetWebSize(gui, 4000, 2000)
    SetWebAlignment(gui, 0.5, 0.5)
    SetWebAnchors(gui, 0.5, 0.5, 0.5, 0.5)
    SetWebVisibility(gui, WEB_VISIBLE)
end
AddEvent("OnPackageStart", OnPackageStart)

AddEvent("OnKeyPress", function(key)
    SetWebVisibility(gui, WEB_HIDDEN)
end)
local function showgui(message, playername)
Delay(1000, function() 
ExecuteWebJS(gui, "updateText('" .. message .. "');")
ExecuteWebJS(gui, "updateName('" .. playername .. "');")
    SetWebVisibility(gui, WEB_HITINVISIBLE)
end)
end
AddRemoteEvent("motd:show", showgui)	

function OnScriptError(message)
	AddPlayerChat('<span color="#ff0000bb" style="bold" size="10">'..message..'</>')
end
AddEvent("OnScriptError", OnScriptError)
