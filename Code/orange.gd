extends Node2D

@onready var self_area: Area2D = $Area2D
@onready var player_area: Area2D = $"../Capybara/Area2D"

signal garlic_collected

func _ready() -> void:
	self_area.area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area == player_area and visible:
		garlic_collected.emit()
		if get_owner().has_method("garlic_collect"):
			get_owner().garlic_collect()
		$Area2D/AnimatedSprite2D.hide()
		$PointLight2D.hide()
		$GPUParticles2D.emitting = true
		await get_tree().create_timer(0.3).timeout
		hide()

func _on_garlic_collected() -> void:
	print("Garlic collected!")
