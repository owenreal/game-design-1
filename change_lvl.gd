extends Area2D

@export var next_level = ""

func _on_body_entered(body: Node2D) -> void:
	if body.name == "plt_player":
		if next_level == "":
			OS.alert("no next level")
	else:
		var lvl = "res://" + next_level + ".tscn"
		get_tree().change_scene_to_file(lvl) 
