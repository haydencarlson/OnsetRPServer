
AddRemoteEvent("joinLotto", function(player)
 message = "number is "..PlayerData[Player].lottonumber
  AddPlayerChat(player, message)
end)

function OnPlayerJoin()
    PlayerData[Player].lottonumber = 0
end)

AddEvent("OnPlayerJoin", OnPlayerJoin)