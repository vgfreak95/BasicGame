extends Node2D

@onready var gos = $CanvasLayer/gameover


var player = null
var time : float = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("player")
	assert(player != null)
	player.on_death.connect(gameover)
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_timer(delta)
	pass


func update_timer(delta):
	time += delta
	$CanvasLayer/stopwatch.text = String.num(time, 2)
	$CanvasLayer/stopwatch.show()

func gameover():
	print("gameover")
	gos._set_score(time)
	#gos._set_highscore(time)
	gos.visible = true
	get_tree().paused = true
