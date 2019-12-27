local onsetrp = ImportPackage("onsetrp")

function hud(player)
    	playername = GetPlayerName(player)
	health = GetPlayerHealth(player)
	armor = GetPlayerArmor(player)
CallRemoteEvent(player, "hud:show", playername, health, armor)
end
AddEvent("OnPlayerJoin", hud)