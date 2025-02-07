extends Label

var timeout : float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.playerHealth <= 0:
		self.visible = true
		timeout += delta
		
	if(timeout > 2.0):
		get_tree().change_scene_to_file("res://title_screen.tscn")
