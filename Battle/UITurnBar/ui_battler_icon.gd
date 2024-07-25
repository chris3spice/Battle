extends TextureRect
class_name UIBattlerIcon

enum Types { ALLY, PLAYER, ENEMY }

const TYPES := {
	Types.ALLY: preload("res://Battle/UITurnBar/portrait_bg_ally.png"),
	Types.PLAYER: preload("res://Battle/UITurnBar/portrait_bg_player.png"),
	Types.ENEMY: preload("res://Battle/UITurnBar/portrait_bg_enemy.png")
}

var position_range : Vector2 = Vector2.ZERO
var battler

@export var icon: Texture:
	set(value):
		icon = value
		if not is_inside_tree(): #Wait for Godot to put it inside the tree
			await(self.ready)
		_icon_node.texture = icon #Sets icon texture
		
@onready var _icon_node: TextureRect = $Icon

func snap(ratio: float) -> void: #moves the icon across the range of the bar
	position.x = lerp(position_range.x, position_range.y, ratio)
