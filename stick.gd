extends Collectible
class_name Stick

func _on_collect(player: Player) -> void:
	var level := get_tree().current_scene.get_node("Level_1")
	level.add_stick()
