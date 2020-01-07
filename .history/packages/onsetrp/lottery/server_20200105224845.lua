AddEvent("joinLotto", function(player, number)
    PlayerData[player].lotto_number = number
    playerid = GetPlayerId(player)
 message = "number is "..PlayerData[player].lotto_number
  AddPlayerChat(player, message)
 
	local query = mariadb_prepare(sql, "INSERT Into lottery_entries SET playerid = ?, lotto_number = ? WHERE id = ? LIMIT 1;",
    playerid
    PlayerData[player].lotto_number
)
    
mariadb_query(sql, query)
end)
AddCommand("lottery", function(player, number)
    CallEvent("joinLotto", player, number)
end)