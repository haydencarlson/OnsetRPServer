local onsetrp = ImportPackage("onsetrp")

local gui = nil

local function OnPackageStart() 
    gui = CreateWebUI(0.0, 0.0, 0.0, 0.0, 5, 16)
    LoadWebFile(gui, "http://asset/" .. GetPackageName() .. "/web/index.html")
    SetWebSize(gui, 1600, 1218)
    SetWebAlignment(gui, 0.5, 0.5)
    SetWebAnchors(gui, 0.5, 0.5, 0.5, 0.5)
    SetWebVisibility(gui, WEB_HITINVISIBLE)
end
AddEvent("OnPackageStart", OnPackageStart)

AddRemoteEvent('hud:update', function(playername, health, armor, hunger, thirst, cash, bank, job)
	ExecuteWebJS(gui, "updateName('" .. playername .. "');")
	ExecuteWebJS(gui, "updateHealth(" .. health .. ");")
	ExecuteWebJS(gui, "updateArmor(" .. armor .. ");")
	ExecuteWebJS(gui, "updateHunger(" .. hunger .. ");")
	ExecuteWebJS(gui, "updateThirst(" .. thirst .. ");")
	ExecuteWebJS(gui, "updateJob('" .. job .. "');")
	ExecuteWebJS(gui, "updateCash(" .. cash .. ");")
	ExecuteWebJS(gui, "updateBank(" .. bank .. ");")
end)

local function showgui()   
	SetWebVisibility(gui, WEB_HITINVISIBLE)
end
AddRemoteEvent("hud:show", showgui)
function OnScriptError(message)
        AddPlayerChat(message)
	print('<span color="#ff0000bb" style="bold" size="10">'..message..'</>')
end
AddEvent("OnScriptError", OnScriptError)