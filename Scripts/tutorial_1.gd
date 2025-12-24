extends Control

# When pressed, goes to level
func _on_continue_pressed() -> void:
	$Sound_button.play()
	await $Sound_button.finished
	get_tree().change_scene_to_file("res://Escenas/level_1.tscn")
