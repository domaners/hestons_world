extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("TEST")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
		get_tree().paused = !get_tree().paused
		$PauseLabel.show()
