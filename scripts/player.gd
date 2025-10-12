extends CharacterBody2D

@export var speed = 130
@export var jump_velocity = -300
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D

var direction := 0  # -1 for left, 1 for right, 0 for idle

func _physics_process(delta):
	# Apply gravity if not on the floor
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle horizontal movement and direction
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
		direction = 1
	elif Input.is_action_pressed("move_left"):
		velocity.x = -speed
		direction = -1
	else:
		velocity.x = 0
		direction = 0

	# Flip sprite based on movement direction
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	# Jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	move_and_slide()
