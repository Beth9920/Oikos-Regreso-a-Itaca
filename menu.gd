extends Node

# When pressed, goes to level
func _on_new_pressed() -> void:
	get_tree().change_scene_to_file("res://level_1.tscn")

# When pressed, quits game
func _on_quit_pressed() -> void:
	get_tree().quit()
