AddCommand("info", function(player)
    CallRemoteEvent(player, "InfoUI:Show")
end)

AddRemoteEvent("SendIsCreatedToInfoUI", function(player, isCreated)
    CallRemoteEvent(player, "InfoUI:PlayerCreated", isCreated)
  end)