local onsetrp = ImportPackage("onsetrp")

local gui = nil

local function OnPackageStart() 
    gui = CreateWebUI(0.0, 0.0, 0.0, 0.0, 5, 16)
    LoadWebFile(gui, "http://asset/" .. GetPackageName() .. "/web/index.html")
    SetWebSize(gui, 1218, 1218)
    SetWebAlignment(gui, 0.5, 0.5)
    SetWebAnchors(gui, 0.5, 0.5, 0.5, 0.5)
	SetWebVisibility(gui, WEB_HIDDEN)

end
AddEvent("OnPackageStart", OnPackageStart)
AddEvent('OnWebLoadComplete', function(web)
	if web == gui then
		CallRemoteEvent("GetInitialHud")
	end
end)

AddRemoteEvent('hud:update', function(playername, hunger, thirst, cash, bank, job)
	ExecuteWebJS(gui, "updateName('" .. playername .. "');")
	ExecuteWebJS(gui, "updateHunger(" .. hunger .. ");")
	ExecuteWebJS(gui, "updateThirst(" .. thirst .. ");")
	ExecuteWebJS(gui, "updateJob('Citizen');")
	ExecuteWebJS(gui, "updateCash(" .. cash .. ");")
	ExecuteWebJS(gui, "updateBank(" .. bank .. ");")
end)

AddRemoteEvent("RPNotify:HUDEvent", function(property, value) 
	local functionName = "update" .. (property:gsub("^%l", string.upper))
	if value ~= nil then
		ExecuteWebJS(gui, functionName .. "('" .. value .. "');")
	end
end)

local function showgui()   
	SetWebVisibility(gui, WEB_HITINVISIBLE)
end
AddRemoteEvent("hud:show", showgui)