local Dialog = ImportPackage("dialogui")
local _ = function(k,...) return ImportPackage("i18n").t(GetPackageName(),k,...) end

local lottomenu

AddEvent("OnKeyPress", function( key )
    if key == "N" then
		Dialog.show(lottomenu)
    end
end)

AddEvent("OnTranslationReady", function()
	lottomenu = Dialog.create(_("lottomenu"), _("joinlotto"), _("cancel"))
    Dialog.addTextInput(lottomenu, 1, _("quantity"))
end)


AddEvent("OnDialogSubmit", function(dialog, button, ...)
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


AddEvent("OnScriptError", function(message)
    AddPlayerChat(player, message)
end)
