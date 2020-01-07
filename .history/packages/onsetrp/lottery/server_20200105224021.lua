AddCommand(lottery, function(player, number)
    CallRemoteEvent("joinLotto", player, number)
end)

AddRemoteEvent("joinLotto", function(player, number)
    PlayerData[player].lotto_number = number
 message = "number is "..PlayerData[player].lotto_number
  AddPlayerChat(player, message)
end)