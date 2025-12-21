extends Area2D
class_name NonCollectible

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_enter)

# Called when a character enters the area of a non collectible
func _on_enter(body: Node) -> void:
	if body is Player:
		_on_encounter(body)

# Called when player encounters object
func _on_encounter(player: Player) -> void:
	pass
