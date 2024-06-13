extends Node2D

var flag = 120


var screen_size
@onready var timer: Timer = $Timer

@export var projectile: PackedScene
@export var max_speed: int = 300
@export var min_speed: int = 100


func spawn_projectile_on_border(width: int, height: int):
	var instance = projectile.instantiate()
	var locations = ["left", "right", "top", "bottom"]
	var border = locations.pick_random()
	var player = get_parent().get_node("Player") as Player  # Create a callable for the player's method
	instance.hit.connect(player._on_projectile_hit)

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
	var scale_vector = randi() % 3 + 1
	instance.scale = Vector2(scale_vector, scale_vector)
	instance.position = Vector2(x, y)

	var speed = randi() % max_speed + min_speed
	add_child(instance)
	instance.speed = speed
	var direction = (player.global_position - instance.global_position).normalized()
	instance.velocity = direction


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	print(screen_size)
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	if flag <= get_parent().time:
		flag = flag + 120.0
		timer.wait_time = timer.wait_time - 0.05
			
	spawn_projectile_on_border(screen_size.x, screen_size.y)
