
AddRemoteEvent("hud:server:show", function(player)
	CallRemoteEvent(player, "InfoUI:Show")
	CallRemoteEvent(player, 'hud:show')
end)
