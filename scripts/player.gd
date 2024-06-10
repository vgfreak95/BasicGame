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


func _process(delta):
	var velocity = Vector2.ZERO

	var cursor_position = get_viewport().get_mouse_position()

	# weapon_sword.render_weapon(global_position)

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


func _on_body_entered(body):
	pass  # Replace with function body.
