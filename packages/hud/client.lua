local onsetrp = ImportPackage("onsetrp")

local hudgui = nil

local function OnPackageStart() 
    hudgui = CreateWebUI(0,0,0,0,0, 16)
	LoadWebFile(hudgui, "http://asset/" .. GetPackageName() .. "/web/index.html")
    SetWebAlignment(hudgui, 0, 0)
    SetWebAnchors(hudgui, 0, 0, 1, 1)
	SetWebVisibility(hudgui, WEB_HIDDEN)

end
AddEvent("OnPackageStart", OnPackageStart)
AddEvent('OnWebLoadComplete', function(web)
	if web == hudgui then
		CallRemoteEvent("GetInitialHud")
	end
end)

AddRemoteEvent('hud:update', function(playername, hunger, thirst, cash, bank, job, time)
	ExecuteWebJS(hudgui, "updateName('" .. playername .. "');")
	ExecuteWebJS(hudgui, "updateHunger(" .. hunger .. ");")
	ExecuteWebJS(hudgui, "updateThirst(" .. thirst .. ");")
	ExecuteWebJS(hudgui, "updateJob('Citizen');")
	ExecuteWebJS(hudgui, "updateCash(" .. cash .. ");")
	ExecuteWebJS(hudgui, "updateBank(" .. bank .. ");")
	ExecuteWebJS(hudgui, "updateTime('" .. time .. "');")
end)

AddRemoteEvent("RPNotify:HUDEvent", function(property, value) 
	local functionName = "update" .. (property:gsub("^%l", string.upper))
	if value ~= nil then
		ExecuteWebJS(hudgui, functionName .. "('" .. value .. "');")
	end
end)

local function showgui()   
	SetWebVisibility(hudgui, WEB_HITINVISIBLE)
end
AddRemoteEvent("hud:show", showgui)