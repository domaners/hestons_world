extends Area2D

@export var destination_name : String

var canEnterStage : bool = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "TopDownPlayer":
		canEnterStage = true
	
func _physics_process(delta):
	var base_path = "res://"
	
	# TODO: To close out issue 30, get label to display on screen
	# if canEnterStage == true:
		# $StageNameLabel.setDeferred("text", "test_level")
		# $StageNameLabel.setDeferred("visible", true)
		
	if Input.is_action_just_pressed("BTN_A") && canEnterStage == true:
		# Load the new scene
		print("Load new scene: " + base_path + destination_name + ".tscn")
		get_tree().change_scene_to_file(base_path + destination_name + ".tscn")

func _on_body_exited(body: Node2D) -> void:
	canEnterStage = false
	# $StageNameLabel.setDeferred("visible", false)
