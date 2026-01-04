extends Area2D
class_name Enemy

@export var speed: float = 160.0
@export var waypoints_root: NodePath

@onready var agent: NavigationAgent2D = $NavigationAgent2D

var waypoints: Array[Node2D] = []
var current_wp: Node2D = null
var sleeping: bool = false

func _ready() -> void:
	randomize()

	#Checks the node of the waypoints has been selected
	if waypoints_root == NodePath():
		return

	#Gets the waypoint node and clears the array
	var wp_node := get_node(waypoints_root)
	waypoints.clear()

	#Goes through the node and adds to the array the valid waypoints
	for c in wp_node.get_children():
		if c is Node2D:
			waypoints.append(c)

	#If there are waypoints in the array, select one
	if waypoints.size() > 0:
		_pick_new_target()


func _physics_process(delta: float) -> void:
	if sleeping or agent == null or waypoints.is_empty():
		return

	# If destination already reached, pick new one
	if agent.is_navigation_finished():
		_pick_new_target()

	var next_point: Vector2 = agent.get_next_path_position() #Coordinates of destination
	var to_next := next_point - global_position #Vector from position to destination
	var dist := to_next.length() #Length of distance vector

	#Checks the distance is not too close to zero
	if dist < 0.05:
		return

	var dir := to_next / dist #Normalizes vector, obtains direction
	global_position += dir * speed * delta


#Selects new target randomly
func _pick_new_target() -> void:
	if waypoints.is_empty(): 
		return

	current_wp = waypoints[randi() % waypoints.size()]
	agent.target_position = current_wp.global_position
