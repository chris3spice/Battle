extends ATBState
class_name ATBActivating

@onready var atb_unit: Node2D = $"../.."

@onready var icon: Marker2D = $"../../Icon"
@onready var choice: Marker2D = $"../../Markers/Choice"
@onready var action: Marker2D = $"../../Markers/Action"
#Timers
@onready var timer: Timer = $"../Timer"

#Other
var length

func _ready() -> void:
	length = action.position.x - choice.position.x #Distance from Choice to Action

func update(delta):
	#MOVES ICON ACROSS BAR
	icon.position.x = ((length/(timer.wait_time/timer.time_left))*-1)
	icon.position.x += length + choice.position.x
	icon.position.y = choice.position.y

func enter():
	timer.wait_time = atb_unit.move_selected.move_activation_time
	timer.start()
