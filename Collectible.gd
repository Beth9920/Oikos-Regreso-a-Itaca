extends Area2D
class_name Collectible

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("READY:", name)
	body_entered.connect(_on_enter)

func _on_enter(body: Node) -> void:
	print("ENTER by:", body.name, " class:", body.get_class())
	if body is Player:
		_on_collect(body)
		queue_free()

func _on_collect(_player: Player) -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
