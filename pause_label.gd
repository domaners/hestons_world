extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("BTN_START"):
		var newPauseState = !get_tree().get("paused")
		get_tree().paused = newPauseState
		self.visible = newPauseState
		# frame_wait = 0.0
