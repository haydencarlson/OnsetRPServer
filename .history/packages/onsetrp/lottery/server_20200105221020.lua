function AddEvent("OnPlayerJoin", function(player)
    PlayerData[Player].lottonumber = 0
end)

AddRemoteEvent("joinLotto", function(player)
 message = "number is "..PlayerData[Player].lottonumber
  AddPlayerChat(player, message)
end)