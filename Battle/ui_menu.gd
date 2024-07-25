extends Control

@onready var battle: Node2D = $"../.."
@onready var ui_action_list: VBoxContainer = $UIActionList

@onready var moves: TextureButton = $HBoxContainer/Moves
@onready var items: TextureButton = $HBoxContainer/Items
@onready var flee: TextureButton = $HBoxContainer/Flee

func setup(battler):
	ui_action_list.setup(battler)

func _on_moves_pressed() -> void: #Show the moves list
	ui_action_list.show()

func _on_items_pressed() -> void: #Show the battle items list
	print("Not implemented yet")
