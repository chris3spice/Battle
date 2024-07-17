extends ATBState
class_name ATBChoosing

func _ready() -> void:
	pass

func update(delta):
	pass

func enter():
	BattleManager.pause.emit() #Emit pause so it'll pause all the timers
	
func exit():
	BattleManager.unpause.emit()
