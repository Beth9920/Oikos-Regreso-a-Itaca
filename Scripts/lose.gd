extends Control

# When pressed, restart level
func _on_try_again_pressed() -> void:
	$Sound_button.play()
	await $Sound_button.finished
	get_tree().change_scene_to_file("res://Escenas/level_1.tscn")

# When pressed, goes to menu
func _on_menu_pressed() -> void:
	$Sound_button.play()
	await $Sound_button.finished
	get_tree().change_scene_to_file("res://Escenas/menu.tscn")
