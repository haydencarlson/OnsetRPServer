AddRemoteEvent("joinLotto", function(player, number)
    PlayerData[player].lotto_number = number
 message = "number is "..number
  AddPlayerChat(player, message)
end)