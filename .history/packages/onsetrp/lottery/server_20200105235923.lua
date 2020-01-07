AddEvent("joinLotto", function(player, number)
    PlayerData[player].lotto_number = number
    message = "Your number is "..PlayerData[player].lotto_number
  AddPlayerChat(player, message)

  local query = mariadb_prepare(sql, "INSERT INTO lottery_entries SET playerid = '?', lotto_number = '?';",
  tostring(PlayerData[player].steamid),
  tostring(PlayerData[player].lotto_number)
)

mariadb_query(sql, query)
end)

AddCommand("lottery", function(player, number)
    CallEvent("joinLotto", player, number)
end)


function OnPackageStart()
        CreateTimer(function()
            local query = mariadb_prepare(sql, "SELECT * from lotteries WHERE status = 'open';")

            mariadb_async_query(sql, query, OnLoadedOpenLottery)
        end)
    end, 3000)
end