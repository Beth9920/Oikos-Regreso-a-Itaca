extends Node

# When pressed, goes to level
func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/level_1.tscn")
