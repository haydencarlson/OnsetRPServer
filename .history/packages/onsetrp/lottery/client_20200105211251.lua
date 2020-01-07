local Dialog = ImportPackage("dialogui")
local _ = function(k,...) return ImportPackage("i18n").t(GetPackageName(),k,...) end

local lottomenu
local lottomenumain

AddEvent("OnTranslationReady", function()
    lottomenu = Dialog.create(_("lottomenu"), _("joinlotto"), _("cancel"))
    lottomenumain = Dialog.create(_("lottomenu"), _("joinlottomenu"), _("cancel"))
    Dialog.addTextInput(lottomenu, 1, _("quantity"))
end)


AddEvent("OnDialogSubmit", function(dialog, button, ...)
    if dialog == lottomenumain then
        if button == 1 then
            Dialog.show(lottomenu)
        end
    end
    if dialog == lottomenu then
		local args = { ... }
		if button == 1 then
            if args[1] == ""  or math.floor(args[1]) < 1 then
                MakeNotification(_("select_amount"), "linear-gradient(to right, #ff5f6d, #ffc371)")
            else
                CallRemoteEvent("joinLotto", math.floor(args[1]))
		end
    end

end)

function OnKeyPress(key)
	if key == "H" and not GetPlayerPropertyValue(GetPlayerId(), 'dead') and not GetPlayerPropertyValue(GetPlayerId(), 'cuffed') then
		AddPlayerChatAll("key pressed")
		Dialog.show(lottomenumain)
	end
end
AddEvent("OnKeyPress", OnKeyPress)

AddEvent("OnScriptError", function(message)
    local message = '<span color="#FF0000"> '..message..' </>'
    AddPlayerChat(player, message)
end)
