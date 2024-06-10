extends Node2D

var screen_size
var timer

@export var projectile: PackedScene
@export var max_speed: int = 300
@export var min_speed: int = 100


func spawn_projectile_on_border(width: int, height: int):
	var instance = projectile.instantiate()
	var locations = ["left", "right", "top", "bottom"]
	var border = locations.pick_random()
	var player = get_parent().get_node("Player") as Player

	var x
	var y

	# Determine what border to spawn projectile on
	if border == "top":
		x = randi() % width
		y = 0

	elif border == "bottom":
		x = randi() % width
		y = height

	elif border == "left":
		x = 0
		y = randi() % height

	elif border == "right":
		x = width
		y = randi() % height

	# Point the instance projectile to the player
	instance.position = Vector2(x, y)
	var velocity = randi() % max_speed + min_speed
	add_child(instance)
	var direction = (player.global_position - instance.global_position).normalized()
	instance.linear_velocity = direction * velocity


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	print(screen_size)
	timer = $Timer
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	spawn_projectile_on_border(screen_size.x, screen_size.y)
