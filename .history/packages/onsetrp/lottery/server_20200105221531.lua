
AddRemoteEvent("joinLotto", function(player)
 message = "number is "
  AddPlayerChat(player, message)
end)

function OnPlayerJoin(player)
    PlayerData[Player].lottonumber = 0
end
AddEvent("OnPlayerJoin", OnPlayerJoin)