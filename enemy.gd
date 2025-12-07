extends Area2D
class_name Enemy

@export var speed: float = 80.0
@export var waypoints_root: NodePath

@onready var agent: NavigationAgent2D = $NavigationAgent2D

var waypoints: Array[Node2D] = []
var current_wp: Node2D = null
var sleeping: bool = false

func _ready() -> void:
	randomize()

	# distancias a las que Poliphemus considera que ha llegado
	agent.path_desired_distance = 4.0
	agent.target_desired_distance = 4.0

	if waypoints_root == NodePath():
		return

	var wp_node := get_node(waypoints_root)
	waypoints.clear()

	for c in wp_node.get_children():
		if c is Node2D:
			waypoints.append(c)

	if waypoints.size() > 0:
		_pick_new_target()


func _physics_process(delta: float) -> void:
	if sleeping:
		return
	
	if agent == null or waypoints.is_empty():
		return

	# si ha llegado al destino actual, elige otro
	if agent.is_navigation_finished():
		_pick_new_target()

	var next_point: Vector2 = agent.get_next_path_position()
	var to_next := next_point - global_position
	var dist := to_next.length()

	if dist < 0.05:
		return

	var dir := to_next / dist
	global_position += dir * speed * delta


func _pick_new_target() -> void:
	if waypoints.is_empty():
		return

	current_wp = waypoints[randi() % waypoints.size()]
	agent.target_position = current_wp.global_position
