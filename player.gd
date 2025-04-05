extends CharacterBody2D

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 180.0
const JUMP_VELOCITY = -350.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2()
var animation_locked : bool = false
var is_paused : bool = false

func _physics_process(delta):
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("BTN_A") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		update_animation("player_jump_up", true)
	if Input.is_action_just_pressed("BTN_X") and is_on_floor():
		# $AudioSwordSwoosh.play()
		update_animation("player_strike", true)
		set_strike_collision()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("DPAD_LEFT", "DPAD_RIGHT", "ui_up", "ui_down")
	if direction.x != 0:
		velocity.x = direction.x * SPEED
		update_animation("player_walk", false)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if !animation_locked:
			update_animation("player_idle", false)
	
	# print("Velocity.x: " + str(velocity.x))
	
	# Handle interactive items such as chests
	if(Input.is_action_just_pressed("BTN_B")):
		handleInteractiveItems()
	
	if(move_and_slide()):
		update_facing_direction()
	
	# Kill the player if they fall off screen
	if(self.position.y > 0):
		Global.playerHealth = 0
		print("FALLEN")
	
func update_facing_direction():
	if direction.x < 0:
		animated_sprite.flip_h = true
		$PlayerSword.position.x = -42.0
	elif direction.x > -1:
		animated_sprite.flip_h = false
		$PlayerSword.position.x = 0

func update_animation(animation_name, set_lock):
	if(!animation_locked):
		animated_sprite.play(animation_name)
		animation_locked = set_lock

# Enables collisions on the sword, for attacking enemies
func set_strike_collision():
	$PlayerSword.process_mode = Node.PROCESS_MODE_ALWAYS 

func _on_animated_sprite_2d_animation_finished():
	$PlayerSword.process_mode = Node.PROCESS_MODE_DISABLED
	animation_locked = false

func handleInteractiveItems():
	
	if(move_and_slide()):
		var lastCollision = get_last_slide_collision()
			
		if(lastCollision.get_collider().is_in_group("Chest")):
			var thisCollidedInstance = instance_from_id(lastCollision.get_collider().get_instance_id())
			thisCollidedInstance.set_deferred("chestOpen", true)
			
			# Where items are allocated to player's inventory based on the contents of the chest
			# Using if's for this is unsustainable but will do for now
			if(thisCollidedInstance.chestContentName == "Wood"):
				Global.playerPickup_Wood += thisCollidedInstance.chestContentQuantity
