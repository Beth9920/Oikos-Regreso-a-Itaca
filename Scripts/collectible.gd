extends Area2D
class_name Collectible

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_enter)

# Called when a character enters the area of a collectible
func _on_enter(body: Node) -> void:
	if body is Player:
		_on_collect(body)
		queue_free()

# Called when player collects an object
func _on_collect(_player: Player) -> void:
	pass
