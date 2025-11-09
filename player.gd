extends CharacterBody2D
class_name Player

@onready var audio : AudioStreamPlayer2D = $AudioStreamPlayer2D

const SPEED = 200.0


func _physics_process(delta: float) -> void:

	var direction := Vector2.ZERO
	
	#Direction depends on last key pressed. 
	if Input.is_action_pressed("Right"):
		direction = Vector2.RIGHT
		$Sprite2D.flip_h = false
	elif Input.is_action_pressed("Up"):
		direction = Vector2.UP
	elif Input.is_action_pressed("Left"):
		direction = Vector2.LEFT
		$Sprite2D.flip_h = true #The character looks to the opposite direction
	elif Input.is_action_pressed("Down"):
		direction = Vector2.DOWN
	
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		audio.play()

	move_and_slide()
