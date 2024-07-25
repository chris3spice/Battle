extends Node2D

@export var background : Texture
@onready var _background: TextureRect = $CanvasLayer/TextureRect
@onready var battler_container: Node2D = $BattlerContainer
@onready var player_pos: Marker2D = $PlayerPos
@onready var opponent_pos: Marker2D = $OpponentPos
@onready var ui_turn_bar: Control = $UI/UITurnBar
@onready var ui_menu: Control = $UI/UIMenu
@onready var ui_battler_hud: Control = $UI/UIBattlerHUD

@export var player_chaomon : Chaomon
@export var opponent_chaomon : Chaomon
@export var is_wild_battle : bool

var battlers : Array #Holds the nodes for the Battlers

#PRELOAD
const BATTLER = preload("res://Battle/battler.tscn")

func _ready() -> void:
	ui_menu.hide() #Make sure player menu is hidden
	_background.texture = background #Sets the background
	
	await setup_battler(player_chaomon, player_pos) #Setup Player Battler
	await setup_battler(opponent_chaomon, opponent_pos) #Setup Opponent Battler
	
	battler_container.setup(battlers) #Run setup for the battlers
	ui_turn_bar.setup(battlers) #Setup the UITurnBar
	ui_battler_hud.setup(battlers) #Setup the HUDS
	

func setup_battler(battler_resource, battler_position):
	var new_battler #To setup battlers with
	new_battler = BATTLER.instantiate()
	new_battler.battler_resource = battler_resource
	new_battler.position = battler_position.position #Set battler position
	battler_container.add_child(new_battler) #Add Btttler to container node
	battlers.append(new_battler) #Add player to battlers array
