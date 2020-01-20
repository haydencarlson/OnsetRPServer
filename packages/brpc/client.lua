local onsetrp = ImportPackage("onsetrp")

local pcui = nil

local function OnPackageStart() 
    pcui = CreateWebUI(0,0,0,0,0, 16)
	LoadWebFile(pcui, "http://asset/" .. GetPackageName() .. "/web/index.html")
    SetWebAlignment(pcui, 0, 0)
    SetWebAnchors(pcui, 0, 0, 1, 1)
	SetWebVisibility(pcui, WEB_HIDDEN)

end
AddEvent("OnPackageStart", OnPackageStart)
AddRemoteEvent('pc:update', function(time)
	ExecuteWebJS(pcui, "updateTime('" .. time .. "');")
end)

local function showpc()   
	SetWebVisibility(pcui, WEB_VISIBLE)
	SetInputMode(INPUT_UI)
end
AddRemoteEvent("pc:show", showpc)
