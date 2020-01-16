local OnsetRP = ImportPackage("onsetrp")
local currentNpc

local cinematicUIWeb = CreateWebUI(0, 0, 0, 0, 2, 60)
SetWebVisibility(cinematicUIWeb, WEB_HIDDEN)
SetWebAlignment(cinematicUIWeb, 0, 0)
SetWebAnchors(cinematicUIWeb, 0, 0, 1, 1)
SetWebURL(cinematicUIWeb, "http://asset/cinematicui/ui.html")

AddEvent("CUIClose", function()
    stopCinematic()
end)

function startCinematic(data, npc, animation)
    currentNpc = npc or GetNearestNPC()
    SetNearClipPlane(15)
    EnableFirstPersonCamera(true)
    ShowChat(false)
    SetIgnoreLookInput(true)
    SetIgnoreMoveInput(true)
    ShowMouseCursor(true)
    SetInputMode(INPUT_GAMEANDUI)
    SetWebVisibility(cinematicUIWeb, WEB_VISIBLE)
    CallRemoteEvent("CUIAnimate", currentNpc, animation)
    ExecuteWebJS(cinematicUIWeb, 'startCinematic('..json_encode(data)..');')
end

function updateCinematic(data, animation)
    if animation then  
        CallRemoteEvent("CUIAnimate", currentNpc, animation)
    end
    ExecuteWebJS(cinematicUIWeb, 'updateCinematic('..json_encode(data)..');')
end

function stopCinematic()
    currentNpc = null
    SetNearClipPlane(0)
    EnableFirstPersonCamera(false)
    ShowChat(true)
    SetIgnoreLookInput(false)
    SetIgnoreMoveInput(false)
    ShowMouseCursor(false)
    SetInputMode(INPUT_GAME)
    SetWebVisibility(cinematicUIWeb, WEB_HIDDEN)
    ExecuteWebJS(cinematicUIWeb, 'stopCinematic(false);')
end

function GetNearestNPC()
    local x, y, z = GetPlayerLocation()
	
	for k, npc in pairs(GetStreamedNPC()) do
        local x2, y2, z2 = GetNPCLocation(npc)

        if GetDistance3D(x, y, z, x2, y2, z2) < 250.0 then
			return npc
		end
	end

	return 0
end

function NpcDelta()
    local x, y, z = GetPlayerLocation()
    local x2, y2, z2 = GetNPCLocation(currentNpc)
    return x2 - x, y2 - y
end

-- Exports

AddFunctionExport("startCinematic", startCinematic)
AddFunctionExport("updateCinematic", updateCinematic)
AddFunctionExport("stopCinematic", stopCinematic)