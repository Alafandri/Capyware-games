extends Node2D

var targetNumber: int
@onready var themedTimer: Node2D = $Timer
var timerEnd: bool = false

func _ready():
	targetNumber = randi_range(1, 9)
	print("Target number: ", targetNumber)
	
	var oranges = [
		$Orange, $Orange2, $Orange3, 
		$Orange4, $Orange5, $Orange6, 
		$Orange7, $Orange8, $Orange9
	]
	
	for i in range(oranges.size()):
		if i < targetNumber:
			oranges[i].visible = true
		else:
			oranges[i].visible = false
			
	$Button.pressed.connect(checkAnswer)
	
	startTimer()

func startTimer():
	await themedTimer.Timer(10.0)
	timerEnd = true

func _process(_delta: float) -> void:
	if timerEnd:
		timerEnd = false
		Global.minigames_done -= 1
		Global.lives -= 1
		get_tree().change_scene_to_file("res://Scenes/Other/level_scene.tscn")

func checkAnswer():
	var playerInput = $LineEdit.text
	if playerInput.is_valid_int():
		if playerInput.to_int() == targetNumber:
			get_tree().change_scene_to_file("res://Scenes/Other/win.tscn")
