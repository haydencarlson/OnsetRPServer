local Dialog = ImportPackage("dialogui")


local lottomenu
local lottoType = "Lottery"

AddEvent("OnKeyPress", function( key )
    if key == "n" then
			Dialog.show(lottomenu)
    end
end)

AddEvent("OnTranslationReady", function()
	lottomenu = Dialog.create(_("lotto_menu"), nil, _("join_lotto"), _("cancel"))
    Dialog.addTextInput(lottomenu, 1, _("quantity"))
end)


AddEvent("OnDialogSubmit", function(dialog, button, ...)
    if dialog == lottomenu then
		local args = { ... }
		if button == 1 then
			local type = lottoType[args[1]]
            if args[2] == ""  or math.floor(args[2]) < 1 then
                MakeNotification(_("select_amount"), "linear-gradient(to right, #ff5f6d, #ffc371)")
            else
                CallRemoteEvent("joinLotto", args[1], math.floor(args[2]))
		end
	end
end)


