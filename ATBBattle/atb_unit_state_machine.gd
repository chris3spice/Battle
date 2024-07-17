extends Node

#STATES
@export var initial_state : ATBState
var current_state : ATBState
var states : Dictionary = {}

#TIMER
@onready var timer: Timer = $Timer

#PAUSE
var is_paused : bool = false

func _ready() -> void:
	BattleManager.pause.connect(_pause) #Connect to BattleManager global pause
	BattleManager.unpause.connect(_unpause) #Connect to BattleManager global unpause
	timer.connect("timeout", _timeout) #Connect to the timer
	for child in get_children(): #Loop through the nodes
		if child is ATBState: #If a node is a state
			states[child.name.to_lower()] = child #Add to dictionary
			child.transition.connect(_on_child_transition) #Connect to transition signal
			
	if initial_state:
		initial_state.enter()
		current_state = initial_state

#RUN PROCESS OF CURRENT STATE
func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

#RUN PHYSICS OF CURRENT STATE
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

#TRANSITION FROM ONE STATE TO NEXT
func _on_child_transition(state, new_state_name):
	if state != current_state:  #If state sending signal isn't the current_state return
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state: #If new_state is null
		return
		
	if current_state: #If there is a current state run the exit
		current_state.exit()
	
	new_state.enter() #Run enter function of new state
	
	current_state = new_state #Change current state to the new state

func _timeout():
	match current_state:
		states.waiting:
			print("done waiting")
			current_state.transition.emit(current_state, "choosing")
		states.activating:
			print("done activating")
			current_state.transition.emit(current_state, "recovering")
		states.recovering:
			print("done recovering")
			current_state.transition.emit(current_state, "waiting")
		
func _pause():
	timer.paused = true
	
func _unpause():
	timer.paused = false
