extends Control

# When pressed, goes to tutorial 1
func _on_new_pressed() -> void:
	$Sound_button.play()
	await $Sound_button.finished
	get_tree().change_scene_to_file("res://Escenas/tutorial_1.tscn")

# When pressed, quits game
func _on_quit_pressed() -> void:
	$Sound_button.play()
	await $Sound_button.finished
	get_tree().quit()

# When pressed, goes to controls screen
func _on_controls_pressed() -> void:
	$Sound_button.play()
	await $Sound_button.finished
	get_tree().change_scene_to_file("res://Escenas/controls.tscn")
