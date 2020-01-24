local onsetrp = ImportPackage("onsetrp")

local pcui = nil
local pcUIOpen = false
local function OnPackageStart() 
    pcui = CreateWebUI(0,0,0,0,0, 16)
	LoadWebFile(pcui, "http://asset/" .. GetPackageName() .. "/web/index.html")
    SetWebAlignment(pcui, 0, 0)
    SetWebAnchors(pcui, 0, 0, 1, 1)
	SetWebVisibility(pcui, WEB_HIDDEN)

end
AddEvent("OnPackageStart", OnPackageStart)

AddRemoteEvent("BRPC:Show", function(PCData)
	ShowMouseCursor(true)
	ExecuteWebJS(pcui, "HydrateUI('".. PCData .."');")
	SetWebVisibility(pcui, WEB_VISIBLE)
	SetInputMode(INPUT_GAMEANDUI)
end)

AddEvent("BRPC:PurchaseUpgrade", function(upgrade)
	CallRemoteEvent("UpgradeCompany", upgrade)
end)

AddEvent("BRPC:HirePlayer", function(player) 
	CallRemoteEvent("HirePlayer", player)
end)

AddEvent("BRPC:FirePlayer", function(player)
	CallRemoteEvent("FirePlayer", player)
end)

AddEvent("BRPC:PayPlayer", function()
	CallRemoteEvent("PayPlayer")
end)

AddRemoteEvent("BRPC:BitcoinPaid", function()
	ExecuteWebJS(pcui, "SetBitcoinAvailable()")
end)

AddRemoteEvent("BRPC:UpgradedCompany", function(upgrade)
	ExecuteWebJS(pcui, "RemoveUpgradeFromSelect('" .. upgrade .. "')")
end)

AddRemoteEvent('pc:update', function(time)
	ExecuteWebJS(pcui, "updateTime('" .. time .. "');")
end)

local function FetchPCData()   
	CallRemoteEvent("BRPC:FetchPCData")
end
AddRemoteEvent("pc:show", FetchPCData)


AddEvent("BRPC:StartOpen", function()
	pcUIOpen = true
	CallRemoteEvent("BRPC:FetchPCData")
end)
AddEvent("OnKeyPress", function( key )
	if key == "F8" and pcUIOpen == false then
		CallEvent("BRPC:StartOpen")
	elseif key == "F8" and pcUIOpen == true then 
		ShowMouseCursor(false)
		pcUIOpen = false
		SetWebVisibility(pcui, WEB_HIDDEN)
		SetInputMode(INPUT_GAME)
	end
end)