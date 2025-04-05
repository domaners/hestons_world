extends Area2D

@export var destination_name : String

var canEnterStage : bool = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "TopDownPlayer":
		Global.mapAreaHighlightName = "test_level"
	
func _physics_process(delta):
	if Input.is_action_just_pressed("BTN_A") && Global.mapAreaHighlightName != "":
		# Load the new scene
		print("Load new scene: res://" + Global.mapAreaHighlightName + ".tscn")
		get_tree().change_scene_to_file("res://" + destination_name + ".tscn")

func _on_body_exited(body: Node2D) -> void:
	Global.mapAreaHighlightName = ""
