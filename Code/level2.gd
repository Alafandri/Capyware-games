extends Node2D

@onready var themed_timer: Node2D = $Timer

var cutcount: int = 0
const MAX_CUTS: int = 5
var timer_end: bool = false
var is_completed: bool = false

func _ready() -> void:
	await themed_timer.Timer(10.0)
	if is_inside_tree() and not is_completed:
		timer_end = true

func grass_cut() -> void:
	if is_completed:
		return
		
	cutcount += 1
	if cutcount >= MAX_CUTS:
		$Correct.play()
		await get_tree().create_timer(0.4).timeout
		is_completed = true
		get_tree().change_scene_to_file("res://Scenes/Other/level_scene.tscn")

func _process(_delta: float) -> void:
	if timer_end:
		timer_end = false
		Global.minigames_done -= 1
		Global.lives -= 1
		get_tree().change_scene_to_file("res://Scenes/Other/level_scene.tscn")
