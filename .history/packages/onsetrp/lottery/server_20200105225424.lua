AddEvent("joinLotto", function(player, number)
    PlayerData[player].lotto_number = number
    message = "number is "..PlayerData[player].lotto_number
  AddPlayerChat(player, message)
  playerid = GetPlayerId(player)
	local query = mariadb_prepare(sql, "INSERT INTO lottery_entries SET playerid = ?, lotto_number = ? WHERE id = ? LIMIT 1;",
    player,
    PlayerData[player].lotto_number
)
    print('done')
mariadb_query(sql, query)
end)

AddCommand("lottery", function(player, number)
    CallEvent("joinLotto", player, number)
end)