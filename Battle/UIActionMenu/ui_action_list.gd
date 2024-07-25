extends VBoxContainer

#PRELOAD
const UI_ACTION_BUTTON = preload("res://Battle/UIActionMenu/ui_action_button.tscn")

func _ready() -> void:
	BattleManager.action_chosen.connect(_reset)

func setup(battler) -> void:
	hide() #Make sure hidden at start
	for action in battler.action_list: #Loop through the actions of the chaomon
		var action_button = UI_ACTION_BUTTON.instantiate() #Create new isntance of button
		action_button.action_resource = action #Pass the action resource to the button
		add_child(action_button) #Add the button to the list
		
		
func _reset(action):
	for i in get_children():
		i.queue_free()
	hide()
	
