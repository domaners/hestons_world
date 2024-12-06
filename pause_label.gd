extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("BTN_START"):
		self.visible = !get_tree().paused
		get_tree().paused = !get_tree().paused
