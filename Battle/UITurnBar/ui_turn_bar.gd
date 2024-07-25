extends Control

const UI_BATTLER_ICON = preload("res://Battle/UITurnBar/ui_battler_icon.tscn")
@onready var _background: TextureRect = $Background

func setup(battlers: Array) -> void:
	for battler in battlers:
		var icon: UIBattlerIcon = create_icon(battler.battler_resource.chaomon_texture) #Create new icon
		_background.add_child(icon) #Add icon to the background
		#battler.connect("readiness_changed", _on_Battler_readiness_changed, [icon])
		battler.readiness_changed.connect(_on_Battler_readiness_changed.bind(icon))

func create_icon(texture: Texture) -> UIBattlerIcon:
	var icon: UIBattlerIcon = UI_BATTLER_ICON.instantiate()
	icon.icon = texture
	icon.position_range = Vector2(
		-icon.size.x / 2.0, -icon.size.x / 2.0 + _background.size.x
	)
	return icon

func _on_Battler_readiness_changed(readiness: float, icon: UIBattlerIcon) -> void:
	icon.snap(readiness / 100.0)
