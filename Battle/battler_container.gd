extends Node2D

var _player : Battler
var _opponent : Battler

var is_player_turn : bool = false

#TODO: REMAP USING SIGNALS
@onready var ui_menu: Control = $"../UI/UIMenu"
@onready var battle: Node2D = $".."

func setup(battlers) -> void:
	BattleManager.action_chosen.connect(_action_chosen) #Connect to action chosen signal
	for battler in battlers:
		battler.ready_to_act.connect(_on_Battler_ready_to_act.bind(battler)) #Connect to signal when battler is ready
		if battler.battler_resource.is_player:
			_player = battler
		else:
			_opponent = battler
		#TODO: Add to party or opponents for double battle

func _on_Battler_ready_to_act(battler: Battler): #When battler readiness is complete
	_play_turn(battler) #Run play turn for the battler

func _pause(value: bool) -> void:
	for battler in get_children(): #Loop through the battlers
		battler.pause(value) #Tell them to pause

func _play_turn(battler: Battler):
	#TODO: Add fatigue system
	await _pause(true) #Pause all of the battlers
	if battler.battler_resource.is_player: #If battler is player
		is_player_turn = true
		ui_menu.setup(battler.battler_resource) #Setup menu for the player
		ui_menu.show()#Show the player's menu
	else: #Opponent AI Turn
		is_player_turn = false
		#Just pick action randomly
		BattleManager.action_chosen.emit(battler.battler_resource.action_list.pick_random())

func _action_chosen(action):
	var formulas = Formulas.new() #Create instance of the formulas for use
	var dmg = 0 #Create variable to hold damage amount
	if is_player_turn:
		print("player turn")
		ui_menu.hide() #Hide the menu
		dmg = formulas.calculate_base_damage(battle.player_chaomon, battle.opponent_chaomon, action)
		battle.opponent_chaomon._take_damage(dmg)
		_reset(_player) #Reset the readiness for player
	else:
		print("opponent turn")
		dmg = formulas.calculate_base_damage(battle.opponent_chaomon, battle.player_chaomon, action)
		battle.opponent_chaomon._take_damage(dmg)
		_reset(_opponent) #Reset the readiness for opponent
	
	_pause(false) #Unpause all of the battlers

func _reset(battler):
	print(battler.battler_resource.chaomon_name)
	battler._readiness = 0.0 #Set readiness back to 0.0
	battler.pause(false)
