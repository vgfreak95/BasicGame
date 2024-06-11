class_name SpeedPickup
extends Pickup


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func on_pickup(player):
	player.current_speed = player.run_speed
	player.speed_powerup_timer.wait_time = 5.0

	if not player.is_speed_powerup_active:
		player.speed_powerup_timer.one_shot = true
		player.speed_powerup_timer.start()
		player.speed_powerup_timer.timeout.connect(player._timer_power_up_timeout)
