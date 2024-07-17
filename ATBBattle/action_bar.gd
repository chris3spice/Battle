extends HBoxContainer

@onready var atb_unit: Node2D = $"../.." #Get access to unit

const MOVE_BUTTON = preload("res://ATBBattle/move_button.tscn")

var skills : Array

func _ready() -> void:
	for n in atb_unit.battle_unit.chaomon_moveset:
		var new_btn = MOVE_BUTTON.instantiate()
		new_btn.move_resource = n
		add_child(new_btn)
	
	skills = get_children()
	for i in get_child_count():
		skills[i].change_key = str(i+1)

func enable(): #Enable all the buttons
	for i in get_child_count():
		if skills[i].timer.time_left > 0:
			skills[i].disabled = true
	#for i in get_child_count():
		#if skills[i].timer.time_left > 0:
			#skills[i].disabled = true
		#else:
			#skills[i].disabled = false
			
	
func disable(): #Disable all the buttons	
	for i in get_child_count():
		if skills[i].timer.time_left > 0:
			skills[i].disabled = false
