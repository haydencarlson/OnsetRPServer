
AddRemoteEvent("joinLotto", function(player)
 message = "number is "..PlayerData[player].lotto_number
  AddPlayerChat(player, message)
end)
