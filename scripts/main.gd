extends Node2D

var time = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_timer(delta)
	pass


func update_timer(delta):
	time += delta
	$CanvasLayer/stopwatch.text = String.num(time, 2)
	$CanvasLayer/stopwatch.show()
