extends Node

# When pressed goes to next level
func _on_next_pressed() -> void:
	pass #When level 2 its available it'll go here

# When pressed, goes to menu
func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/menu.tscn")
