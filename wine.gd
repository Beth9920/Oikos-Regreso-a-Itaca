extends Collectible

#Defines what happens when player collects wine
func _on_collect(player: Player) -> void:
	get_tree().current_scene.add_wine()
