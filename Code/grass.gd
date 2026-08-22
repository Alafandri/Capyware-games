extends Node2D

@onready var grass_sprite: AnimatedSprite2D = $Grass

var cutcount: int = 0
const MAX_CUTS: int = 5

func _ready() -> void:
	$Area2D.input_event.connect(_on_area_2d_input_event)

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if not event.pressed:
			perform_cut()

func perform_cut() -> void:
	$Area2D/CollisionShape2D.disabled = true
	grass_sprite.play("cut")
	$Grass2.play()
	get_parent().grass_cut()
