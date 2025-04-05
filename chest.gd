extends StaticBody2D

var chestOpen : int = false
var pickupVal = 10

@export var chestContentName : String = ""
@export var chestContentQuantity : int = 0

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
