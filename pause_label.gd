extends Label

var frame_wait : float = 0.0 # Ensures the user cannot spam the pause button, this seems to get the player stuck sometimes...

const PAUSE_BUFFER : float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	print("Current pause state: " + str(get_tree().paused))
	print("Delta: " + str(delta))
	
	# Put some buffer in place so that the level doesn't begin paused. There must be a better way of handling this!!!
	frame_wait = frame_wait + delta
	if(frame_wait < PAUSE_BUFFER):
		return
	
	if Input.is_action_just_pressed("BTN_START"):
		print("Previous pause state: " + str(get_tree().paused))
		if(get_tree().paused == false):
			self.visible = true
			get_tree().set_deferred("paused", true)
			frame_wait = 0
		else:
			self.visible = false
			get_tree().set_deferred("paused", false)
			frame_wait = 0
		print("New pause state: " + str(get_tree().paused))
