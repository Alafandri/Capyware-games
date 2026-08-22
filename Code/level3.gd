extends Node2D
@onready var themed_timer: Node2D = $Timer
var timer_end = false
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	await themed_timer.Timer(10.0)
	timer_end = true
func _process(_delta: float) -> void:
	if timer_end: # if the timer does end...
		Global.minigames_done -=1 #go back a minigame
		Global.lives -= 1 # lose ur lives
		get_tree().change_scene_to_file("res://Scenes/Other/level_scene.tscn") # back to intermission
