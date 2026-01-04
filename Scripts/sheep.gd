extends NonCollectible
class_name Sheep

signal BLEAT(sheep: Node2D)

@onready var audio : AudioStreamPlayer2D = $AudioStreamPlayer2D

# When player encounters a sheep, the sheeps emits a signal 
func _on_encounter(player: Player) -> void:
	emit_signal("BLEAT", self)
	audio.play()
