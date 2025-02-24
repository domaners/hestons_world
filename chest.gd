extends CharacterBody2D

var chestOpen : int = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(chestOpen):
		$ChestClosed.set_deferred("visible", false)
		$ChestOpen.set_deferred("visible", true)
	else:
		$ChestClosed.set_deferred("visible", true)
		$ChestOpen.set_deferred("visible", false)
		
	
	if move_and_slide() && is_on_wall():
		var lastCollision = get_last_slide_collision()	
		if(lastCollision.get_collider().is_in_group("Player")):
			chestOpen = true
