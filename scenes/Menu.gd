extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_button_pressed():
	print("Play was pressed")
	get_tree().change_scene("res://scenes/main.tscn")


func _on_quit_pressed():
	print("Quit was pressed")
