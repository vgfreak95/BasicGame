extends Node2D

@export var power_up_to_use: PackedScene
@export var max_powerups_on_screen = 3
@onready var screen_size = get_viewport_rect().size

@onready var timer = $Timer


func _ready():
	timer.start()


func create_power_up():
	# TODO: Add random power up choice here

	var power_up = power_up_to_use.instantiate() as PowerUpSpeed
	var player = get_parent().get_node("Player") as Player  # Create a callable for the player's method
	power_up.pickup.connect(player._on_power_up_pickup.bind(power_up))

	var x = randi() % int(screen_size.x)
	var y = randi() % int(screen_size.y)

	add_child(power_up)
	power_up.position = Vector2(x, y)


func _on_timer_timeout():
	var current_power_ups_on_screen = get_tree().get_nodes_in_group("powerup").size()
	if current_power_ups_on_screen < max_powerups_on_screen:
		create_power_up()
