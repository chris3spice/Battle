extends Node2D
class_name Battler

@onready var sprite: Sprite2D = $Sprite2D

var battler_resource : Chaomon
var _readiness : float = 0.0 #Used to determine if Battler is ready to attack
var _is_paused : bool = false

var _fatigue : int = 0 #FUTURE: Used to track the fatigue level
var _timescale : float = 1.0 #FUTURE: Used to change the speed based on fatigue level

#Signals
signal readiness_changed(new_value)
signal ready_to_act

func _ready() -> void:
	sprite.texture = battler_resource.chaomon_texture #Set the sprite

func _physics_process(delta: float) -> void:
	if battler_resource and !_is_paused: #If the resource is correct and it isn't paused
		_set_readiness(_readiness + battler_resource.base_speed * delta * _timescale) #Set the readiness

#Sets the readiness of the Chaomon
func _set_readiness(value: float) -> void: #Set the readiness of the Battler
	_readiness = value #Set readiness
	readiness_changed.emit(_readiness) #Emit the new readiness
	if _readiness >= 100.0: #If battler is ready to act
		ready_to_act.emit() #Signal that battler is ready to act
		set_physics_process(false) #Stop processing

func pause(value: bool): #Set the pause variable
	if value:
		set_physics_process(false)
	else:
		set_physics_process(true)
