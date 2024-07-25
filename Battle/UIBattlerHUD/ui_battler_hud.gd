extends Control

#Preload the UIBattlerHUD
const UI_BATTLER_HUD = preload("res://Battle/UIBattlerHUD/UIBattlerHud.tscn")
#Get markers to use for positioning
@onready var opponent_hud: Marker2D = $OpponentHUD
@onready var player_hud: Marker2D = $PlayerHUD

func setup(battlers: Array) -> void:
	for battler in battlers: #Loop through the battlers
		var hud = UI_BATTLER_HUD.instantiate() #Create new HUD
		if battler.battler_resource.is_player == true:
			hud.position = player_hud.position
		else:
			hud.position = opponent_hud.position
		add_child(hud)
			 
		
