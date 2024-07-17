extends Node2D

@export var battle_unit : Chaomon
@export var move_selected : Move
@onready var control: CanvasLayer = $Control

func _ready() -> void:
	if battle_unit.is_player:
		control.visible = true
	else:
		control.visible = false
