extends Control

@onready var scores : Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _set_score(value):
	scores.append(value)
	$PanelContainer/VBoxContainer/score.text = "Score: " + String.num(value, 2)
	

#func _set_highscore(value):
	#$PanelContainer/VBoxContainer/highscore.text = "Highscore: " + String.num(scores.max(), 2)


func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_quit_pressed():
	get_tree().quit()
