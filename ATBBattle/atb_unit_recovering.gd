extends ATBState
class_name ATBRecovering

@onready var atb_unit: Node2D = $"../.."

@onready var icon: Marker2D = $"../../Icon"
@onready var action: Marker2D = $"../../Markers/Action"
@onready var end: Marker2D = $"../../Markers/End"

#Timers
@onready var timer: Timer = $"../Timer"

#Other
var length

func _ready() -> void:
	length = end.position.x - action.position.x #Distance from Start to Choice

func update(delta):
	#MOVES ICON ACROSS BAR
	icon.position.x = ((length/(timer.wait_time/timer.time_left))*-1)
	icon.position.x += length + action.position.x
	icon.position.y = action.position.y

func enter():
	timer.wait_time = atb_unit.move_selected.move_recovery_time
	timer.start()
