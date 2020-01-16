# Cinematic-UI
An easy-to-use UI to create simple cinematic conversations with NPCs on Onset

## Demo:
[![Demo](https://j.gifs.com/D1xDlY.gif)](https://www.youtube.com/watch?v=K3zaY7evqhk)  
[FULL DEMO AVAILABLE HERE](https://www.youtube.com/watch?v=K3zaY7evqhk)

## Import package:
```
local CUI = ImportPackage("cinematicui")
```
## Functions:
### `CUI.startCinematic(params, npc*, animation*)`
- #### params (Table)
```
{
	title = "NPC Name",
	message = "Hello world!"
	actions = {
		{
			text = "Yes",
			callback = "YesClickedOnCUI",
			close_on_click = true
		},
		{
			text = "No"
			callback = "NoClickedOnCUI"
		}
	}
}
```

Please note that, in this example, `YesClickedOnCUI` and `NoClickedOnCUI` are events registered in your package like this:
```
AddEvent("YesClickedOnCUI", function()
	-- Do something
end)
```
- #### npc (Number, optional)
The Npc identifier (by default, it will be the closest NPC)
- #### animation (String, optional)
An animation present in the [AnimationList](https://dev.playonset.com/wiki/AnimationList). Default is `WAVE2`

### `CUI.updateCinematic(params, npc*, animation*)`
- #### params (Table)
Same as `CUI.startCinematic`.
Please note that if`title` and/or `message` is/are empty, the UI will keep those sent to`startCinematic`. Not sending any `actions` will remove buttons from the UI.
### `CUI.stopCinematic(params, npc*, animation*)`
Stops the cinematic.
