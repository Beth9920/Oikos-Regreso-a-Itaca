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

#Connects to sheep
func _connect_sheep() -> void:
	#Gets level node
	var level := get_parent().get_parent()

	#Gets non_collectibles node
	var non_collectibles := get_parent().get_parent().get_node("Non_Collectibles")
	if non_collectibles == null:
		return
		
	#Goes through sheep and connects to their signals
	for sheep in non_collectibles.get_children():
		if sheep.has_signal("BLEAT"):
			if not sheep.BLEAT.is_connected(_on_sheep_bleat):
				sheep.BLEAT.connect(_on_sheep_bleat)

#When Poliphemous encounters Odysseus
func _on_body_entered(body: Node) -> void:
	#Poliphemus only reacts to encounters with player
	if not (body is Player):
		return

	#Gets level node
	var level := get_parent().get_parent()

	# If sleeping and player has all sticks, player wins
	if sleeping:
		if level.sticks >= BLIND_STICKS_REQUIRED:
			_go_blind()
			level.player_wins()
		return

	# When awake, if player has wine enough, goes to sleep. If player doesn't have enough wine, game over
	if level.spend_wine(WINE_COST_TO_SLEEP):
		_go_to_sleep()
	elif level.wine >= WINE_COST_TO_SLEEP:
		level.wine -= WINE_COST_TO_SLEEP
		_go_to_sleep()
	else:
		_kill_player(body)

# If Poliphemus hears one of his sheep, goes to her
func _on_sheep_bleat(sheep: Node2D) -> void:
	#If Poliphemus is sleeping, wakes up
	if sleeping:
		sleeping = false
		_update_sprite()
		_update_sound()

	#Forgets current destination and goes to sheep
	if agent:
		current_wp = null
		agent.target_position = sheep.global_position

# Polifemo falls asleep
func _go_to_sleep() -> void:
	sleeping = true
	_update_sprite()
	_update_sound()

# Polifemo goes blind
func _go_blind() -> void:
	blind = true
	sleeping = false
	if agent:
		current_wp = null
		agent.target_position = global_position
	_update_sprite()
	_update_sound()

# Updates Poliphemus sprite
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
