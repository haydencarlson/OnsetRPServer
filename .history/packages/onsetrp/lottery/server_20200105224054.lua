AddEvent("joinLotto", function(player, number)
    PlayerData[player].lotto_number = number
 message = "number is "..PlayerData[player].lotto_number
  AddPlayerChat(player, message)
end)
AddCommand(lottery, function(player, number)
    CallEvent("joinLotto", player, number)
end)