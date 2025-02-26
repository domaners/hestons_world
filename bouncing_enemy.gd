extends CharacterBody2D

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

@export var move_speed : float = 100.0
@export var move_dir : Vector2 = Vector2()
@export var gravity_speed : int = 200
@export var lateral_speed : int = 50
@export var available_score : int = 20 
var enemyHealth = 2

const JUMP_VELOCITY = -125.0

var animation_locked : bool = false
var moveRight = false
var logCount = 0

func _ready():
	velocity.x = -lateral_speed
	
func _physics_process(delta):
	
	if moveRight == true:
		velocity.x = lateral_speed
	else:
		velocity.x = -lateral_speed
		
	#update_animation("enemy_walk", false)
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
	else:
		velocity.y += gravity_speed * delta
			
	if move_and_slide() && is_on_wall():
		var lastCollision = get_last_slide_collision()
		if(lastCollision.get_collider().is_in_group("PlayerSword")):
			print("HIT PLAYER SWORD")
			killEnemy()
		elif(lastCollision.get_collider().is_in_group("Player")):
			print("HIT PLAYER - LOSE 10 HEALTH")
			decreasePlayerHealth(10)
			
		moveRight = !moveRight
		# update_facing_direction()
		animated_sprite.flip_h = moveRight
		print("CHANGE MOVERIGHT: " + str(moveRight))

func update_animation(animation_name, set_lock):
	if(!animation_locked):
		animated_sprite.play(animation_name)
		animation_locked = set_lock

func killEnemy():
	enemyHealth -= 1
	Global.playerScore += available_score
	if(enemyHealth <= 0):
		self.get_parent().generate_pickup(self.position)
		queue_free()
	
func decreasePlayerHealth(amount):
	Global.playerHealth -= amount
