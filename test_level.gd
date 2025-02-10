extends Node2D

var new_pickup = preload("res://pickup.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func generate_pickup(pos: Vector2):
	var this_pickup = new_pickup.instantiate()
	add_child(this_pickup)
	this_pickup.set("position", pos)
