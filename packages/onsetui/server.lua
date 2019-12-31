function gui_data(player)
    local playername = GetPlayerName(player)
    local message = "<h1>Welcome to BalanceRP</h1>"
    CallRemoteEvent(player, "motd:show", playername, message)
end

AddRemoteEvent("GetStartScreenData", gui_data)
