local gui = CreateWebUI(0.0, 0.0, 4000, 2000, 5, 16)
LoadWebFile(gui, "http://asset/" .. GetPackageName() .. "/web/index.html")
SetWebAlignment(gui, 0.5, 0.5)
SetWebAnchors(gui, 0.5, 0.5, 0.5, 0.5)
SetWebVisibility(gui, WEB_VISIBLE)

AddEvent("OnKeyPress", function(key)
    SetWebVisibility(gui, WEB_HIDDEN)
end)
