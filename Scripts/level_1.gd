extends Node2D

var wine := 0
var sticks := 0

var wine_counter: Label
var sticks_counter: Label

func _ready() -> void:
	wine_counter = get_node_or_null("UI_Level1/Counters/WineCounter")
	sticks_counter = get_node_or_null("UI_Level1/Counters/SticksCounter")
	_update_counters()


func add_wine():
	wine += 1
	_update_counters()


func add_stick():
	sticks += 1
	_update_counters()


func spend_wine(amount: int) -> bool:
	if wine >= amount:
		wine -= amount
		_update_counters()
		return true
	return false


func _update_counters():
	if wine_counter:
		wine_counter.text = "Vino: " + str(wine)
	if sticks_counter:
		sticks_counter.text = "Palos: " + str(sticks)

func player_wins() -> void:
	get_tree().change_scene_to_file("res://Escenas/win.tscn")
	print("LEVEL COMPLETE")
	
