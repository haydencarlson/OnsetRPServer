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

end)


AddEvent("OnDialogSubmit", function(dialog, button, ...)
    if dialog == gpsmenu then
		local args = { ... }
		if button == 1 then
			local type = lottoType[args[1]]
            local number = 
		end
	end
end)


