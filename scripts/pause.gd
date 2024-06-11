extends Control


func _ready():
	hide()


func resume():
	hide()
	get_tree().paused = false


func pause():
	show()
	get_tree().paused = true


func escPause():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()


func _on_resume_pressed():
	resume()


func _on_quit_pressed():
	get_tree().quit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	escPause()
