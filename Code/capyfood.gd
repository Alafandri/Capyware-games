extends Sprite2D

var capyfeededcount: int = 0
var original_position: Vector2
var is_dragging: bool = false

@onready var themed_timer: Node2D = $"../Timer"
var timer_end: bool = false

func _ready() -> void:
	original_position = global_position
	if themed_timer and themed_timer.has_signal("timeout"):
		themed_timer.connect("timeout", Callable(self, "_on_timer_timeout"))

func _process(_delta: float) -> void:
	if timer_end:
		timer_end = false
		Global.minigames_done -= 1
		Global.lives -= 1
		get_tree().change_scene_to_file("res://Scenes/Other/level_scene.tscn")
		return

	if is_dragging:
		global_position = get_global_mouse_position()


func _on_button_button_down() -> void:
	is_dragging = true


func _on_button_button_up() -> void:
	is_dragging = false
	
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = get_global_mouse_position()
	query.collide_with_areas = true
	query.collide_with_bodies = false
	
	var results = space_state.intersect_point(query)
	
	for result in results:
		var area = result.collider
		if area is Area2D and area.monitoring:
			capyfeededcount += 1
			$"../Pet2".play()
			print("capy feeded")
			
			area.set_deferred("monitoring", false)
			area.set_deferred("monitorable", false)
			
			var target_parent = area.get_parent()
			if target_parent and target_parent.has_node("AnimationPlayer"):
				target_parent.get_node("AnimationPlayer").play("new_animation")
			elif target_parent is AnimatedSprite2D:
				target_parent.play("new_animation")
			
			var particles = $"../AnimatedSprite2D5/GPUParticles2D"
			particles.global_position = target_parent.global_position
			particles.restart()
			
			if capyfeededcount >= 5:
				_finish_game()
			
			break
	
	global_position = original_position


func _on_timer_timeout() -> void:
	timer_end = true


func _finish_game() -> void:
	set_process(false)
	$"../AudioStreamPlayer2D".play()
	await get_tree().create_timer(0.4).timeout
	get_tree().change_scene_to_file("res://Scenes/Other/level_scene.tscn")
