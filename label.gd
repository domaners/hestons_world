extends Label

func _ready() -> void:
	self.visible = false
	
func _physics_process(delta: float) -> void:
	if(Global.mapAreaHighlightName != ""):
		self.visible = true
	else:
		self.visible = false
		
	self.text = Global.mapAreaHighlightName
