extends Control

func _on_back_pressed() -> void:
	$Sound_button.play()
	await $Sound_button.finished
	get_tree().change_scene_to_file("res://Escenas/menu.tscn")
