extends Collectible
class_name Stick

func _on_collect(player: Player) -> void:
	get_tree().current_scene.add_stick()
