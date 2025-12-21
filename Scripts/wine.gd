extends Collectible
class_name Wine

func _on_collect(player: Player) -> void:
	get_tree().current_scene.add_wine()
	
