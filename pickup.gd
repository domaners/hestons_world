extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if move_and_slide() && is_on_wall():
		var lastCollision = get_last_slide_collision()	
		if(lastCollision.get_collider().is_in_group("Player")):
			print("GOT PICKUP")
			Global.playerPickups += 1
			queue_free()
