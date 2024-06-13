extends Node2D

# @export var power_up_to_use: PackedScene
@export var pickups_to_use: Array[PackedScene]
@export var max_powerups_on_screen = 3
@onready var screen_size = get_viewport_rect().size

@onready var timer = $Timer


func _ready():
	timer.start()


func create_power_up():
	var spawn_pickup_time: float = randf_range(8.0, 15.0)
	timer.wait_time = spawn_pickup_time
	var pickup = pickups_to_use.pick_random().instantiate()

	var x = randi() % int(screen_size.x)
	var y = randi() % int(screen_size.y)

	add_child(pickup)
	pickup.position = Vector2(x, y)


func _on_timer_timeout():
	var current_power_ups_on_screen = get_tree().get_nodes_in_group("pickup").size()
	if current_power_ups_on_screen < max_powerups_on_screen:
		create_power_up()
