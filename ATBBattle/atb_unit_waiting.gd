extends ATBState
class_name ATBWaiting

@onready var atb_unit: Node2D = $"../.."

@onready var icon: Marker2D = $"../../Icon"
@onready var start: Marker2D = $"../../Markers/Start"
@onready var choice: Marker2D = $"../../Markers/Choice"
#Timers
@onready var timer: Timer = $"../Timer"

#Other
var length

func _ready() -> void:
	length = choice.position.x - start.position.x #Distance from Start to Choice

func update(delta):
	#MOVES ICON ACROSS BAR
	icon.position.x = ((length/(timer.wait_time/timer.time_left))*-1)
	icon.position.x += length + start.position.x
	icon.position.y = start.position.y

func enter():
	timer.wait_time = atb_unit.battle_unit.chaomon_speed
	timer.start()
