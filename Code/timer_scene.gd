extends Node2D
@onready var garlic_container: HBoxContainer = $CanvasLayer/HBoxContainer
@onready var garlic: TextureRect = $CanvasLayer/HBoxContainer/TextureRect
@onready var garlic_2: TextureRect = $CanvasLayer/HBoxContainer/TextureRect2
@onready var garlic_3: TextureRect = $CanvasLayer/HBoxContainer/TextureRect3
@onready var garlic_4: TextureRect = $CanvasLayer/HBoxContainer/TextureRect4
@onready var garlic_5: TextureRect = $CanvasLayer/HBoxContainer/TextureRect5
@onready var level: RichTextLabel = $CanvasLayer/Level
@onready var timer: RichTextLabel = $CanvasLayer/Timer
@onready var level_1: Node2D = $CanvasLayer/Level1
@onready var level_2: Node2D = $CanvasLayer/Level2
@onready var level_3: Node2D = $CanvasLayer/Level3

var time

func _ready() -> void:
	level_1.visible = (Global.minigames_done == 0)
	level_2.visible = (Global.minigames_done == 1)
	level_3.visible = (Global.minigames_done == 2)
	
	await Timer(3.0)
	
	if Global.lives <= 0:
		return
	
	if Global.minigames_done < 3:
		Global.minigames_done = Global.minigames_done + 1
		get_tree().change_scene_to_file("res://Scenes/Games/" + str(Global.minigames_done) + ".tscn") 

	else:
		get_tree().change_scene_to_file("res://Scenes/Other/Menu.tscn") 
	

func _process(_delta: float) -> void:
	if Global.lives <= 0:
		get_tree().change_scene_to_file("res://Scenes/Other/lose.tscn")
		return

	match Global.lives:
		4:
			garlic.hide()
		3:
			garlic.hide()
			garlic_2.hide()
		2:
			garlic.hide()
			garlic_2.hide()
			garlic_3.hide()
		1:
			garlic.hide()
			garlic_2.hide()
			garlic_3.hide()
			garlic_4.hide()
		0:
			garlic_container.hide() 
	
	timer.text = str(time) 
	level.text = "Level " + str(Global.minigames_done + 1) 

func Timer(start_time: float): 
	time = start_time 
	
	while time > 0.0: 
		await wait(0.1) 
		time -= 0.1 
	
	return

func wait(seconds: float) -> void: 
	await get_tree().create_timer(seconds).timeout
