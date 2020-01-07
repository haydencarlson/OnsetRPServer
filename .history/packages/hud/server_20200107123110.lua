
AddRemoteEvent("hud:server:show", function(player)
	CallRemoteEvent(player, 'hud:show')
	CallRemoteEvent(player, "InfoUI:Show")
end)
