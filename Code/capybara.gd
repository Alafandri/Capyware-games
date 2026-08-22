extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var MINJUMPVELOCITY = -150.0
@export var COYOTETIME: float = 0.15
@export var JUMPBUFFERTIME: float = 0.15

var coyotetimer: float = 0.0
var jumpbuffertimer: float = 0.0

var isgrounded = true

func _physics_process(delta: float) -> void:
	
	
	if isgrounded == false and is_on_floor() == true:
		$GPUParticles2D.restart()
		$GPUParticles2D.emitting = true
	
	isgrounded = is_on_floor()
	
	if is_on_floor():
		coyotetimer = COYOTETIME
	else:
		coyotetimer -= delta

	if Input.is_action_just_pressed("ui_accept"):
		jumpbuffertimer = JUMPBUFFERTIME
	else:
		jumpbuffertimer -= delta

# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

# Handle jump.
	if jumpbuffertimer > 0.0 and coyotetimer > 0.0:
		velocity.y = JUMP_VELOCITY
		coyotetimer = 0.0
		jumpbuffertimer = 0.0

	if Input.is_action_just_released("ui_accept") and velocity.y < MINJUMPVELOCITY:
		velocity.y = MINJUMPVELOCITY

# Get the input direction and handle the movement/deceleration.
# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.flip_h = (direction < 0)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if not is_on_floor():
		$AnimatedSprite2D.play("Jump")
	elif direction != 0:
		$AnimatedSprite2D.play("Walk")
	else:
		$AnimatedSprite2D.play("Idle")

	move_and_slide()
