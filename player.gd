extends CharacterBody2D

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 180.0
const JUMP_VELOCITY = -350.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2()
var animation_locked : bool = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	elif !animation_locked:
		update_animation("player_idle", false)
	
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_just_pressed("Ctrl") and is_on_floor():
		update_animation("player_strike", true)
		set_strike_collision()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction.x != 0:
		velocity.x = direction.x * SPEED
		update_animation("player_walk", true)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	update_facing_direction()
	
func update_facing_direction():
	if direction.x < 0:
		animated_sprite.flip_h = true
	elif direction.x > 0:
		animated_sprite.flip_h = false

func update_animation(animation_name, set_lock):
	if(!animation_locked):
		animated_sprite.play(animation_name)
		animation_locked = set_lock

# Enables collisions on the sword, for attacking enemies
func set_strike_collision():
	$CollisionShape2DSword.set_deferred("disabled", false)

func _on_animated_sprite_2d_animation_finished():
	$CollisionShape2DSword.set_deferred("enabled", false)
	animation_locked = false
