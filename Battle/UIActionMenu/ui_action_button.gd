extends TextureButton

@onready var icon: TextureRect = $HBoxContainer/Icon
@onready var label: Label = $HBoxContainer/Label

var action_resource : Action

func _ready() -> void:
	icon.texture = action_resource.action_icon #Set icon based on resource
	label.text = action_resource.action_name #Set name based on resource

func _on_pressed() -> void:
	BattleManager.action_chosen.emit(action_resource)
