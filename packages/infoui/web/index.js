(function(obj) {
    ue.game = {};
    ue.game.callevent = function(name, ...args) {
        if (typeof name != "string") {
            return;
        }

        if (args.length == 0) {
            obj.callevent(name, "")
        } else {
            let params = []
            for (let i = 0; i < args.length; i++) {
                params[i] = args[i];
            }
            obj.callevent(name, JSON.stringify(params));
        }
    };
    var CallEvent = ue.game.callevent;
    document.getElementById('info-ui-close').addEventListener('click', function() {
        CallEvent("InfoUI:Close");
    });
})(ue.game);