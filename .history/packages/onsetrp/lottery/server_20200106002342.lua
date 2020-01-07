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
    end, 3000)
end

function OnLoadedOpenLottery()
    local lottery = mariadb_get_assoc(1)
    local query = mariadb_prepare(sql, "SELECT * FROM lotteries_entries WHERE lottery_id = '?';", lottery['id'])
    mariadb_query(sql, query)
    mariadb_async_query(sql, query, OnLoadedLotteryEntries)
end

function OnloadedLotteryEntries()
    generated_number = Random(1, 150)
    for i = 1, mariadb_get_row_count() do
        local entry = mariadb_get_assoc(i)
        if entry['lotto_number'] == generated_number then
         AddPlayerChatAll("You Won")
        else
            AddPlayerAll("You lost")
        end
      end
end