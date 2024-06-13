extends Node2D

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
	if get_parent().time >= 720:  #Kill Screen
		timer.wait_time = 0.05
	elif get_parent().time >= 480:
		timer.wait_time = 0.10
	elif get_parent().time >= 360:
		timer.wait_time = 0.15
	elif get_parent().time >= 240:
		timer.wait_time = 0.20
	elif get_parent().time >= 120:
		timer.wait_time = 0.25
	spawn_projectile_on_border(screen_size.x, screen_size.y)
