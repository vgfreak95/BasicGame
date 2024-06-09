extends Node2D

var screen_size
var timer

@export var projectile: PackedScene
# Figure out how to get the player coords

func spawn_projectile_on_border(width: int, height: int):
	
	var instance = projectile.instantiate()
	var locations = ["left", "right", "top", "bottom"]
	var border = locations.pick_random()
	
	var x
	var y
	var angle
	
	# Determine what border to spawn projectile on
	if border == 'top':
		x = randi() % width
		y = 0

	elif border == 'bottom':
		x = randi() % width
		y = height
	elif border == 'left':
		x = 0
		y = randi() % height
	elif border == 'right':
		x = width
		y = randi() % height
		
	# Set the velocity towards the player
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	var direction = randf_range(0.0, 360.0)
	
	#var add_to_scale = randi() % 3
	#var vector_scale = Vector2(add_to_scale, add_to_scale)
	#instance.scale += vector_scale
	
	instance.linear_velocity = velocity.rotated(direction)
	instance.position = Vector2(x, y)
	
	add_child(instance)

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
