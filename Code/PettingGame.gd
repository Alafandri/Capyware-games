extends AnimatedSprite2D

@export var petsrequired = 30
var newrequiredpets = 30

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if newrequiredpets <= 0:
		newrequiredpets = 1
		get_tree().change_scene_to_file("res://Scenes/Other/win.tscn")

func _on_button_button_down() -> void:
	$".".play("Down")
	$"../AudioStreamPlayer2D".play()
	$"../GPUParticles2D".emitting = true
	newrequiredpets = newrequiredpets - 1
	$"../CanvasLayer/Counter".text = "Pets left: " + str(newrequiredpets)


func _on_button_button_up() -> void:
	$".".play("Up")
	$"../GPUParticles2D".emitting = false
