extends NonCollectible
signal BLEAT(sheep: Node2D)

@onready var audio : AudioStreamPlayer2D = $AudioStreamPlayer2D
#Defines what happens when player collects wine
func _on_encounter(player: Player) -> void:
	emit_signal("BLEAT", self)
	audio.play()
