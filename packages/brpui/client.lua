local brpui
local BRPUIOpen = false
AddEvent("OnPackageStart", function()
    brpui = CreateWebUI(0.0, 0.0, 0.0, 0.0, 5, 16)
    LoadWebFile(brpui, "http://asset/" .. GetPackageName() .. "/ui/index.html")
    SetWebSize(brpui, 1218, 1080)
    SetWebAlignment(brpui, 0.5, 0.5)
    SetWebAnchors(brpui, 0.5, 0.5, 0.5, 0.5)
    SetWebVisibility(brpui, WEB_HIDDEN)
end)

AddEvent("SelectJob", function(selection)
    CallRemoteEvent("JobSelected", selection)
end)

AddEvent("Hide:BRPUI", function() 
    SetWebVisibility(brpui, WEB_HIDDEN)
    ShowMouseCursor(false)
    SetInputMode(INPUT_GAME)
end)

AddRemoteEvent("JobSelectionSetup", function()
    ExecuteWebJS(brpui, "JobSelectSetup()")
end)

AddRemoteEvent("AddJobToJobSelection", function(job)
    ExecuteWebJS(brpui, "AddJobToSelection('".. json_encode(job) .. "')")
end)

AddRemoteEvent("ShowJobSelection", function()
    SetWebVisibility(brpui, WEB_VISIBLE)
    ShowMouseCursor(true)
    SetInputMode(INPUT_UI)
    ExecuteWebJS(brpui, "ShowJobSelection()")
end)