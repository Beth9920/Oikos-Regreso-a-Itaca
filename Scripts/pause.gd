extends Control

func _play():
	get_tree().paused = false
	visible = false
	
func _pause():
	get_tree().paused = true
	visible = true
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		if get_tree().paused:
			_play()
		else:
			_pause()
			


func _on_continue_pressed() -> void:
	$Sound_button.play()
	await $Sound_button.finished
	_play()


func _on_quit_pressed() -> void:
	$Sound_button.play()
	await $Sound_button.finished
	get_tree().quit()
