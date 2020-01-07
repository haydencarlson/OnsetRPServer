local _ = function(k,...) return ImportPackage("i18n").t(GetPackageName(),k,...) end
PlayerData = {}

function OnPackageStart()
    -- Save all player data automatically 
    CreateTimer(function()
		for k, v in pairs(GetAllPlayers()) do
            SavePlayerAccount(v)
		end
		print("All accounts have been saved !")
    end, 30000)
end
AddEvent("OnPackageStart", OnPackageStart)

function OnPlayerSteamAuth(player)

	CreatePlayerData(player)
	PlayerData[player].steamname = GetPlayerName(player)
    
    AddPlayerChatAll('<span color="#eeeeeeaa">'..GetPlayerName(player)..' from '..PlayerData[player].locale..' joined</>')
	AddPlayerChatAll('<span color="#eeeeeeaa">'..GetPlayerCount()..' players online</>')
	AddPlayerChat(player, '<span color="#ff0000" size="17">/info in the chat to view key shortcuts and server information. Go check it out!</>')
    
    -- First check if there is an account for this player
	local query = mariadb_prepare(sql, "SELECT id FROM accounts WHERE steamid = '?' LIMIT 1;",
    tostring(GetPlayerSteamId(player)))

    mariadb_async_query(sql, query, OnAccountLoadId, player)
end
AddEvent("OnPlayerSteamAuth", OnPlayerSteamAuth)

function OnPlayerQuit(player)
    SavePlayerAccount(player)

    DestroyPlayerData(player)
end
AddEvent("OnPlayerQuit", OnPlayerQuit)

function OnAccountLoadId(player)
	if (mariadb_get_row_count() == 0) then
		--There is no account for this player, continue by checking if their IP was banned		
        local query = mariadb_prepare(sql, "SELECT FROM_UNIXTIME(bans.ban_time), bans.reason FROM bans WHERE bans.steamid = ?;",
			tostring(GetPlayerSteamId(player)))

		mariadb_async_query(sql, query, OnAccountCheckBan, player)
	else
		--There is an account for this player, continue by checking if it's banned
        PlayerData[player].accountid = mariadb_get_value_index(1, 1)
		local query = mariadb_prepare(sql, "SELECT FROM_UNIXTIME(bans.ban_time), bans.reason FROM bans WHERE bans.steamid = ?;",
			tostring(GetPlayerSteamId(player)))

		mariadb_async_query(sql, query, OnAccountCheckBan, player)
	end
end

function OnAccountCheckBan(player)
	if (mariadb_get_row_count() == 0) then
		--No ban found for this account
		CheckForIPBan(player)
	else
		--There is a ban in the database for this account
		local result = mariadb_get_assoc(1)

		print("Kicking "..GetPlayerName(player).." in the butt! Account banned.")

		KickPlayer(player, _("banned_for", result['reason'], result['FROM_UNIXTIME(bans.ban_time)']))
	end
end

function CheckForIPBan(player)
	local query = mariadb_prepare(sql, "SELECT ipbans.reason FROM ipbans WHERE ipbans.ip = '?' LIMIT 1;",
		GetPlayerIP(player))

	mariadb_async_query(sql, query, OnAccountCheckIpBan, player)
end

function OnAccountCheckIpBan(player)
	if (mariadb_get_row_count() == 0) then
		--No IP ban found for this account
		if (PlayerData[player].accountid == 0) then
			CreatePlayerAccount(player)
		else
			LoadPlayerAccount(player)
		end
	else
		print("Kicking "..GetPlayerName(player).." in the butt! IP banned.")

		local result = mariadb_get_assoc(1)
        
        KickPlayer(player, "🚨 You have been banned from this server.")
	end
end

function CreatePlayerAccount(player)
	local query = mariadb_prepare(sql, "INSERT INTO accounts (id, steamid, clothing, clothing_police, death_pos, inventory, position, police) VALUES (NULL, '?', '[]' , '[]' , '[]', '[]' , '[]', '1');",
		tostring(GetPlayerSteamId(player)))

	mariadb_query(sql, query, OnAccountCreated, player)
end


function OnAccountCreated(player)
	PlayerData[player].accountid = mariadb_get_insert_id()

	CallRemoteEvent(player, "askClientCreation")

	SetPlayerLoggedIn(player)
	SetAvailablePhoneNumber(player)
	setPositionAndSpawn(player, nil)

	print("Account ID "..PlayerData[player].accountid.." created for "..player)

	AddPlayerChat(player, '<span color="#ffff00aa" style="bold italic" size="15">Welcome '..GetPlayerName(player)..'</>')
	AddPlayerChatAll('<span color="00ee00ff">'..PlayerData[player].accountid..' total players</>')
end

function LoadPlayerAccount(player)
	local query = mariadb_prepare(sql, "SELECT * FROM accounts WHERE id = ?;",
		PlayerData[player].accountid)

	mariadb_async_query(sql, query, OnAccountLoaded, player)
end

function LoadPlayerPhoneContacts(player)
	local query = mariadb_prepare(sql, "SELECT * FROM phone_contacts WHERE phone_contacts.owner_id = ? ORDER BY phone_contacts.name;", PlayerData[player].accountid)

	mariadb_async_query(sql, query, OnPhoneContactsLoaded, player)
end

function AddBalanceToAccount(player, account, amount)
	local bank_bal = math.tointeger(PlayerData[player].bank_balance)
	local amount_to_add = amount
	local action = {
		cash = function(amount_to_add, bank_bal) 
			AddPlayerCash(player, amount_to_add)
			CallRemoteEvent(player, "RPNotify:HUDEvent", "cash", GetPlayerCash(player))
		end,
		bank = function(amount_to_add, bank_bal)
			PlayerData[player].bank_balance = bank_bal + amount_to_add
			CallRemoteEvent(player, "RPNotify:HUDEvent", "bank", PlayerData[player].bank_balance)
		end
	}
	action[account](amount_to_add, bank_bal)
end

function RemoveBalanceFromAccount(player, account, amount)
	local bank_bal = PlayerData[player].bank_balance
	local amount_to_remove = amount
	local action = {
		cash = function(player, amount_to_remove, bank_bal) 
			RemovePlayerCash(player, amount_to_remove)
			CallRemoteEvent(player, "RPNotify:HUDEvent", "cash", GetPlayerCash(player))
		end,
		bank = function(player, amount_to_remove, bank_bal)
			PlayerData[player].bank_balance = bank_bal - amount_to_remove
			CallRemoteEvent(player, "RPNotify:HUDEvent", "bank", PlayerData[player].bank_balance)
		end
	}
	action[account](player, amount_to_remove, bank_bal)
end

function OnAccountLoaded(player)
	if (mariadb_get_row_count() == 0) then
		--This case should not happen but still handle it
		KickPlayer(player, "An error occured while loading your account ??")
	else
		local result = mariadb_get_assoc(1)
		PlayerData[player].admin = math.tointeger(result['admin'])
		PlayerData[player].bank_balance = math.tointeger(result['bank_balance'])
		PlayerData[player].name = tostring(result['name'])
		PlayerData[player].clothing = json_decode(result['clothing'])
		PlayerData[player].clothing_police = json_decode(result['clothing_police'])
		PlayerData[player].police = math.tointeger(result['police'])
		PlayerData[player].driver_license = math.tointeger(result['driver_license'])
		PlayerData[player].gun_license = math.tointeger(result['gun_license'])
		PlayerData[player].helicopter_license = math.tointeger(result['helicopter_license'])
		PlayerData[player].inventory = json_decode(result['inventory'])
		PlayerData[player].created = math.tointeger(result['created'])
		PlayerData[player].position = json_decode(result['position'])
		if result['phone_number'] and result['phone_number'] ~= "" then
			PlayerData[player].phone_number = tostring(result['phone_number'])
		else
			SetAvailablePhoneNumber(player)
		end
		SetPlayerPropertyValue(player, "actionInProgress", 'false', true)
		SetPlayerHealth(player, tonumber(result['health']))
		SetPlayerArmor(player, tonumber(result['armor']))
		setPlayerThirst(player, tonumber(result['thirst']))
		setPlayerHunger(player, tonumber(result['hunger']))
		setPositionAndSpawn(player, PlayerData[player].position)
		SetPlayerLoggedIn(player)
		
		if math.tointeger(result['created']) == 0 then
			CallRemoteEvent(player, "askClientCreation")
		else
			SetPlayerName(player, PlayerData[player].name)
		
			playerhairscolor = getHairsColor(PlayerData[player].clothing[2])
			CallRemoteEvent(player, "ClientChangeClothing", player, 0, PlayerData[player].clothing[1], playerhairscolor[1], playerhairscolor[2], playerhairscolor[3], playerhairscolor[4])
			CallRemoteEvent(player, "ClientChangeClothing", player, 1, PlayerData[player].clothing[3], 0, 0, 0, 0)
			CallRemoteEvent(player, "ClientChangeClothing", player, 4, PlayerData[player].clothing[4], 0, 0, 0, 0)
			CallRemoteEvent(player, "ClientChangeClothing", player, 5, PlayerData[player].clothing[5], 0, 0, 0, 0)
			-- CallRemoteEvent(player, "AskSpawnMenu")
		end
		LoadPlayerPhoneContacts(player)

		print("Account ID "..PlayerData[player].accountid.." loaded for "..GetPlayerIP(player))
	end
end

function setPositionAndSpawn(player, position) 
	SetPlayerSpawnLocation(player, 212727.4375, 175845.5, 1309.1500244141, 90)
	if position ~= nil and position.x ~= nil and position.y ~= nil and position.z ~= nil then
		SetPlayerLocation(player, PlayerData[player].position.x, PlayerData[player].position.y, PlayerData[player].position.z + 150) -- Pour empêcher de se retrouver sous la map
	else
		SetPlayerLocation(player, 212727.4375, 175845.5, 1309.1500244141)
	end
end

function SetAvailablePhoneNumber(player)
	-- Generate a random phone number
	local phone_number = "555"..tostring(math.random(100000, 999999))

	local query = mariadb_prepare(sql, "SELECT id FROM accounts WHERE phone_number = ?;",
		phone_number)

	mariadb_async_query(sql, query, OnPhoneNumberChecked, player, phone_number)
end

function OnPhoneNumberChecked(player, phone_number)
	if (mariadb_get_row_count() == 0) then
		-- If phone number is available
		local query = mariadb_prepare(sql, "UPDATE accounts SET phone_number = ? WHERE id = ?", phone_number, PlayerData[player].accountid)

		PlayerData[player].phone_number = phone_number

		mariadb_async_query(sql, query)
	else
		-- Retry with a new phone number if the generated one is already allowed to another account
		GetAvailablePhoneNumber(player)
	end
end

function OnPhoneContactsLoaded(player)
	for i = 1, mariadb_get_row_count() do
		local contact = mariadb_get_assoc(i)
		if contact['id'] then
			PlayerData[player].phone_contacts[i] = { id = tostring(contact['id']),  name = contact['name'], phone = contact['phone'] }
		end
	end

	print("Phone contacts loaded for "..PlayerData[player].accountid)
end

function CreatePlayerData(player)
	PlayerData[player] = {}

	PlayerData[player].accountid = 0
	PlayerData[player].name = ""
	PlayerData[player].clothing = {}
	PlayerData[player].clothing_police = {}
	PlayerData[player].police = 1
	PlayerData[player].medic = 0
	PlayerData[player].inventory = { cash = 100 }
	PlayerData[player].driver_license = 0
	PlayerData[player].gun_license = 0
	PlayerData[player].helicopter_license = 0
	PlayerData[player].logged_in = false
	PlayerData[player].admin = 0
	PlayerData[player].created = 0
	PlayerData[player].locale = GetPlayerLocale(player)
	PlayerData[player].steamid = GetPlayerSteamId(player)
	PlayerData[player].steamname = ""
	PlayerData[player].thirst = 100
	PlayerData[player].hunger = 100
	PlayerData[player].bank_balance = 900
	PlayerData[player].job_vehicle = nil
	PlayerData[player].job = ""
	PlayerData[player].onAction = false
	PlayerData[player].isActioned = false
	PlayerData[player].phone_contacts = {}
	PlayerData[player].phone_number = {}
	PlayerData[player].health_state = "alive"
	PlayerData[player].death_pos = {}
	PlayerData[player].position = {}
	PlayerData[Player].lottonumber = 0


    print("Data created for : "..player)
end

function DestroyPlayerData(player)
	if (PlayerData[player] == nil) then
		return
	end
	
	if PlayerData[player].job_vehicle ~= nil then
        DestroyVehicle(PlayerData[player].job_vehicle)
        DestroyVehicleData( PlayerData[player].job_vehicle)
        PlayerData[player].job_vehicle = nil
    end

	PlayerData[player] = nil
	print("Data destroyed for : "..player)
end

function SavePlayerAccount(player)
	if (PlayerData[player] == nil) then
		return
	end
	if (PlayerData[player].accountid == 0 or PlayerData[player].logged_in == false) then
		return
	end


	-- Sauvegarde de la position du joueur
	local x, y, z = GetPlayerLocation(player)
	PlayerData[player].position = {x= x, y= y, z= z}

	local query = mariadb_prepare(sql, "UPDATE accounts SET admin = ?, bank_balance = ?, health = ?, health_state = '?', death_pos = '?', armor = ?, hunger = ?, thirst = ?, name = '?', clothing = '?', clothing_police = '?', inventory = '?', created = '?', position = '?', driver_license = ?, gun_license = ?, helicopter_license = ? WHERE id = ? LIMIT 1;",
		PlayerData[player].admin,
		PlayerData[player].bank_balance,
		100,
		PlayerData[player].health_state,
		json_encode(PlayerData[player].death_pos),
		GetPlayerArmor(player),
		PlayerData[player].hunger,
		PlayerData[player].thirst,
		PlayerData[player].name,
		json_encode(PlayerData[player].clothing),
		json_encode(PlayerData[player].clothing_police),
		json_encode(PlayerData[player].inventory),
		PlayerData[player].created,
		json_encode(PlayerData[player].position),
		PlayerData[player].driver_license,
		PlayerData[player].gun_license,
		PlayerData[player].helicopter_license,
		PlayerData[player].accountid
	)
        
	mariadb_query(sql, query)
end

function SetPlayerLoggedIn(player)
    PlayerData[player].logged_in = true
end

function IsAdmin(player)
	return PlayerData[player].admin
end

AddFunctionExport("isAdmin", IsAdmin)