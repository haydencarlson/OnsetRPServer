AddRemoteEvent("joinLotto", function(player, number)
 message = "number is "..math.floor(number)
  AddPlayerChat(player, message)
end)