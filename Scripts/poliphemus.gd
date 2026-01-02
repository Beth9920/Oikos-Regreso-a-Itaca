extends Enemy
class_name Poliphemus

@onready var sprite: Sprite2D = $Sprite2D
@onready var steps: AudioStreamPlayer2D = $Steps
@onready var snoring: AudioStreamPlayer2D = $Snoring

@export var awake_texture: Texture2D
@export var sleeping_texture: Texture2D
@export var blind_texture: Texture2D

const WINE_COST_TO_SLEEP := 5
const BLIND_STICKS_REQUIRED := 337

var blind: bool = false


func _ready() -> void:
	super._ready()
	_update_sprite()
	_update_sound()
	body_entered.connect(_on_body_entered)
	_connect_sheep()


func _connect_sheep() -> void:
	var level := get_parent().get_parent()

	var non_collectibles := get_parent().get_parent().get_node("Non_Collectibles")
	if non_collectibles == null:
		return

	for sheep in non_collectibles.get_children():
		if sheep.has_signal("BLEAT"):
			if not sheep.BLEAT.is_connected(_on_sheep_bleat):
				sheep.BLEAT.connect(_on_sheep_bleat)

#Cuando Polifemo encuentra a Odiseo
func _on_body_entered(body: Node) -> void:
	if not (body is Player):
		return

	var level := get_parent().get_parent()
	
	#Si ya ha sido cegado, no reaccionará
	if blind:
		return

	# Si está dormido y el jugador tiene todos los palos, se gana la partida
	if sleeping:
		if level.sticks >= BLIND_STICKS_REQUIRED:
			_go_blind()
			level.player_wins()
		return

	# Si está despierto y el jugador tiene vino suficiente, dormirá. Si no, se pierde la partida.
	if level.spend_wine(WINE_COST_TO_SLEEP):
		_go_to_sleep()
	elif level.wine >= WINE_COST_TO_SLEEP:
		level.wine -= WINE_COST_TO_SLEEP
		_go_to_sleep()
	else:
		_kill_player(body)

# Si polifemo oye a una de sus ovejas acude a ella
func _on_sheep_bleat(sheep: Node2D) -> void:
	if blind:
		return

	if sleeping:
		sleeping = false
		_update_sprite()
		_update_sound()

	if agent:
		current_wp = null
		agent.target_position = sheep.global_position

# Polifemo se duerme
func _go_to_sleep() -> void:
	sleeping = true
	_update_sprite()
	_update_sound()

# Polifemo se vuelve ciego
func _go_blind() -> void:
	blind = true
	sleeping = false
	if agent:
		current_wp = null
		agent.target_position = global_position
	_update_sprite()
	_update_sound()

# Actualizar la imagen de Polifemo
func _update_sprite() -> void:
	if blind and blind_texture:
		sprite.texture = blind_texture
	elif sleeping and sleeping_texture:
		sprite.texture = sleeping_texture
	elif awake_texture:
		sprite.texture = awake_texture

# Updates sounds
func _update_sound() -> void:
	if blind:
		if steps.playing:
			steps.stop()
		if snoring.playing:
			snoring.stop()
		return
	
	elif sleeping:
		if steps.playing:
			steps.stop()
		if not snoring.playing:
			snoring.play()
		return
	
	else:
		if snoring.playing:
			snoring.stop()
		if not steps.playing:
			steps.play()
	

# Game over
func _kill_player(_player: Player) -> void:
	get_tree().change_scene_to_file("res://Escenas/lose.tscn")
	print("You are dead")
