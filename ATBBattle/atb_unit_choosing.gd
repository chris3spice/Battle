extends ATBState
class_name ATBChoosing

@onready var atb_unit: Node2D = $"../.."
@onready var action_bar: HBoxContainer = $"../../Control/ActionBar"

func _ready() -> void:
	if atb_unit.battle_unit.is_player:
		BattleManager.move_selected.connect(_move_selected)

func enter():
	BattleManager.pause.emit() #Pause all the timers
	if atb_unit.battle_unit.is_player: #If players turn
		print("Player chooses")
		action_bar.enable() #Enable all the buttons
	else: #If opponents turn
		print("Enemy chooses")
		_move_selected(atb_unit.battle_unit.chaomon_moveset.pick_random())
	
func exit():
	BattleManager.unpause.emit() #Unpause all the timers

func _move_selected(move_resource):
	atb_unit.move_selected = move_resource
	print(atb_unit.move_selected)
	action_bar.disable() #Disable all the buttons
	transition.emit(self, "activating") #Change state to activating
