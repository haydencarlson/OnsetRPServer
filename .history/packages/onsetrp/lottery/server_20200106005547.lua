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
    print("Querying db for open lottery")
    CreateTimer(function()
        local query = mariadb_prepare(sql, "SELECT * from lotteries WHERE status = 'open';")
        print("Querying db for open lottery")
        mariadb_async_query(sql, query, OnLoadedOpenLottery)
end, 3000)
end
AddEvent("OnPackageStart", OnPackageStart)

function OnLoadedOpenLottery()
local lottery = mariadb_get_assoc(1)
print("Found one open lottery id: ")
print(lottery['id'])
local query = mariadb_prepare(sql, "SELECT * FROM lottery_entries WHERE lottery_id = '?';", lottery['id'])
print("Querying for open lottery entries")
mariadb_async_query(sql, query, OnLoadedLotteryEntries)
end

function OnLoadedLotteryEntries()
generated_number = 77
for i = 1, mariadb_get_row_count() do
    local entry = mariadb_get_assoc(i)
    print(entry['lotto_number'])
    print(player)
    if entry['lotto_number'] == generated_number then
        AddPlayerChat(player, "You Won")
    end
end
print(generated_number)
end