-- Based on MasterCedric (https://github.com/MasterCedric/)

web = nil
UINotAlreadyOpen = false
function OnPackageStart()
	web = CreateWebUI(0, 0, 0, 0, 10)
	LoadWebFile(web, "http://asset/" .. GetPackageName() .. "/animation/web/index.html")
	SetWebSize(web, 700, 700)
	SetWebAlignment(web, 0.5, 0.5)
	SetWebAnchors(web, 0.5, 0.5, 0.5, 0.5)
	SetWebVisibility(web, WEB_HIDDEN)
end
AddEvent("OnPackageStart", OnPackageStart)

function OnKeyPress(key)
	if key == "F2" and not onSpawn and not onCharacterCreation and UINotAlreadyOpen == true then
		if(GetWebVisibility(web) == 0) then
			SetWebVisibility(web, WEB_VISIBLE)
			ShowMouseCursor(true)
			SetInputMode(INPUT_GAMEANDUI)
			UINotAlreadyOpen = true
		else
			SetWebVisibility(web, WEB_HIDDEN)
			ShowMouseCursor(false)
			SetInputMode(INPUT_GAME)
			UINotAlreadyOpen = false
		end
	end
end
AddEvent("OnKeyPress", OnKeyPress)

function OnPlayerAnimation(id)
	CallRemoteEvent("Server_OnPlayerAnimation", id)
end
AddEvent("OnPlayerAnimation", OnPlayerAnimation)
