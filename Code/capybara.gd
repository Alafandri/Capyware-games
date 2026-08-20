extends CharacterBody2D

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	# 1. Apply Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# 2. Handle Jump Input
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# 3. Handle Horizontal Movement
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.flip_h = (direction < 0) # Flips sprite when moving left
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# 4. Handle Animations (Separated from physics logic)
	update_animations(direction)

	move_and_slide()

func update_animations(direction: float) -> void:
	if not is_on_floor():
		$AnimatedSprite2D.play("Jump")
	elif direction != 0:
		$AnimatedSprite2D.play("Walk")
	else:
		$AnimatedSprite2D.play("Idle")
