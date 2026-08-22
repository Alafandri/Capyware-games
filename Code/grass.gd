extends Node2D

@onready var grass_sprite: AnimatedSprite2D = $Grass

static var cutcount: int = 0
const maxcuts: int = 5

func _ready() -> void:
	$Area2D.input_event.connect(_on_area_2d_input_event)

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if not event.pressed:
			perform_cut()

func perform_cut() -> void:
	cutcount += 1
	grass_sprite.play("cut")
	
	if cutcount >= maxcuts:
		cutcount = 0
		Global.minigames_done = Global.minigames_done + 0
		get_tree().change_scene_to_file("res://Scenes/Other/level_scene.tscn")
