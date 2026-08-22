extends Node2D


@onready var startbutton: Button = $CanvasLayer/Start
@onready var settingsbutton: Button = $CanvasLayer/Settings
@onready var quitbutton: Button = $CanvasLayer/Quit

func _ready() -> void:
	startbutton.pressed.connect(_on_start_pressed)
	settingsbutton.pressed.connect(_on_settings_pressed)
	quitbutton.pressed.connect(_on_quit_pressed)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Other/level_scene.tscn")

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Other/Settings.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
