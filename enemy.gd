extends Area2D

@export var move_speed : float = 30.0
@export var move_dir : Vector2 = Vector2()

var start_position : Vector2 = Vector2()
var target_position : Vector2 = Vector2(0, 0)
#var global_position : Vector2 = Vector2()
var directionLeft : bool = true

func _ready():
	start_position = global_position
	target_position = start_position + move_dir
	
func _process(delta):
	
	if(directionLeft):
		target_position.x = -10000000
	else: 
		target_position.x = 10000000
		
	global_position = global_position.move_toward(target_position, move_speed * delta)
	
	
				
		# if global_position == start_position:
		#	target_position = start_position + move_dir
		#else:
		#	target_position = start_position


func _on_body_entered(body):
	
	# Change movement direction of enemy
	if body.is_in_group("Leveltiles"):
		print("HITTING THE LEVEL")
		if(directionLeft == true):
			directionLeft = false
		else: 
			directionLeft = true
	
	# Check collision with player
	if body.is_in_group("Player"): 
		print("HIT PLAYER")
	elif body.is_in_group("PlayerSword"):
		print("HIT ENEMY")
