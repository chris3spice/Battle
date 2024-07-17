extends TextureButton

var move_resource : Move

@onready var progress_bar: TextureProgressBar = $TextureProgressBar
@onready var timer: Timer = $Timer
@onready var time: Label = $Time
@onready var key: Label = $Key
 
var change_key = "":
	set(value):
		change_key = value
		key.text = value
 
		shortcut = Shortcut.new()
		var input_key = InputEventKey.new()
		input_key.keycode = value.unicode_at(0)
 
		shortcut.events = [input_key]
 
func _ready():
	change_key = "1"
	progress_bar.max_value = timer.wait_time
 
func _process(_delta):
	time.text = "%3.1f" % timer.time_left
	progress_bar.value = timer.time_left
 
func _on_pressed():
	timer.start()
	disabled = true
 
	BattleManager.move_selected.emit(move_resource)
 
 
func _on_timer_timeout():
	time.text = ""
