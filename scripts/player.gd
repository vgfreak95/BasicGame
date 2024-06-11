class_name Player
extends Area2D

# Player Specific Informa
var current_speed = 200
var walk_speed = 200
var run_speed = 400
var direction = 1

@onready var player = $AnimatedPlayer2D
@onready var collision = $CollisionShape2D
@onready var player_attributes = $AttributesComponent
@onready var weapon_sword = $WeaponSword
@onready var weapon_animation = $WeaponSword/AnimationPlayer
@onready var screen_size = get_viewport_rect().size

@onready var health_bar: ProgressBar = $ProgressBar
@onready var health: HPComponent = $HPComponent


func _ready():
	health_bar.value = health.max_health


func _process(delta):
	var velocity = Vector2.ZERO

	var cursor_position = get_viewport().get_mouse_position()

	# Don't rotate player when weapon is used
	if not weapon_animation.is_playing():
		if get_position() < cursor_position:
			player.flip_h = false
		else:
			player.flip_h = true

	# Processing user input
	if Input.is_action_pressed("move_down"):
		velocity.y += 1

	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if Input.is_action_pressed("move_left"):
		velocity.x -= 1

	if Input.is_action_pressed("move_right"):
		velocity.x += 1

	if Input.is_action_just_pressed("mouse_left"):
		weapon_sword.use_weapon()

	# When the player is moving
	if velocity.length() > 0:
		velocity = velocity.normalized() * current_speed
		position += velocity * delta
		position = position.clamp(Vector2.ZERO, screen_size)
		player.play()

	# When the player has stopped pressing buttons/moving
	else:
		player.stop()


# For enemy entities
func _on_body_entered(body):
	if body as Projectile != null:
		health.take_damage()
		health_bar.value = health.current_health
		# TODO: Handle Death scenario


# For Powerups
func _on_area_entered(area: Area2D):
	if area as PowerUpSpeed != null:
		current_speed = run_speed
		var duration_timer = Timer.new()
		duration_timer.wait_time = 5.0
		add_child(duration_timer)
		duration_timer.one_shot = true
		duration_timer.start()
		duration_timer.timeout.connect(_timer_power_up_timeout)
		area.queue_free()


func _timer_power_up_timeout():
	current_speed = walk_speed
