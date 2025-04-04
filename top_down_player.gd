extends CharacterBody2D

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 50.0
# const JUMP_VELOCITY = -350.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2()

func _physics_process(delta):
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("DPAD_LEFT", "DPAD_RIGHT", "ui_up", "ui_down")
	if direction.x != 0:
		velocity.x = direction.x * SPEED
		#update_animation("player_walk", false)
	else:
		velocity.x = 0
	
	if direction.y != 0:
		velocity.y = direction.y * SPEED
	else:
		velocity.y = 0
	
	if(move_and_slide()):
		# update_facing_direction()
		
		var lastCollision = get_last_slide_collision()
			
		if(lastCollision.get_collider().is_in_group("map_entry_point")):
			var thisCollidedInstance = instance_from_id(lastCollision.get_collider().get_instance_id())
			print("Entry point to: " + thisCollidedInstance.destination_name)

func update_facing_direction():
	if direction.x < 0:
		animated_sprite.flip_h = true

	elif direction.x > -1:
		animated_sprite.flip_h = false
