class_name Player
extends CharacterBody2D

# Player Specific Informa
var current_speed = 200
var walk_speed = 200
var run_speed = 400
var direction = 1

@onready var player = $AnimatedPlayer2D
@onready var animation_player = $AnimationPlayer
@onready var collision = $CollisionShape2D
@onready var player_attributes = $AttributesComponent
@onready var weapon_sword = $WeaponSword
@onready var weapon_animation = $WeaponSword/AnimationPlayer
@onready var screen_size = get_viewport_rect().size

@onready var health_bar: ProgressBar = $VBoxContainer/HealthBar
@onready var speed_bar: ProgressBar = $VBoxContainer/SpeedBar
@onready var health: HPComponent = $HPComponent

@onready var speed_powerup_timer: Timer = Timer.new()
@onready var is_speed_powerup_active = false
@onready var is_movement_locked = false


func take_damage(damage):
	health.lose_health(damage)


func heal(amount):
	health.restore_health(amount)


func lock_movement():
	is_movement_locked = true


func unlock_movement():
	is_movement_locked = false


func move_player(delta):
	var velocity = Vector2.ZERO
	var cursor_position = get_viewport().get_mouse_position()

	# Processing user input
	if Input.is_action_pressed("move_down"):
		velocity.y += 1

	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if Input.is_action_pressed("move_left"):
		velocity.x -= 1

	if Input.is_action_pressed("move_right"):
		velocity.x += 1

	player.flip_h = false if position < cursor_position else true

	# When the player is moving
	if velocity.length() > 0:
		velocity = velocity.normalized() * current_speed
		position += velocity * delta
		position = position.clamp(Vector2.ZERO, screen_size)
		player.play("walk")

	# When the player has stopped pressing buttons/moving
	else:
		player.stop()


func update_bars():
	# Bar to timer
	speed_bar.value = speed_powerup_timer.time_left * 20
	health_bar.value = health.current_health


func _ready():
	health_bar.value = health.max_health
	add_child(speed_powerup_timer)


func _process(delta):
	if not is_movement_locked:
		move_player(delta)
		update_bars()


func _on_projectile_hit(damage):
	take_damage(damage)


func _timer_power_up_timeout():
	current_speed = walk_speed
	is_speed_powerup_active = false


func _on_hp_component_on_death():
	lock_movement()
	player.stop()
	player.flip_h = false
	animation_player.play("death")
	await animation_player.animation_finished

	# TODO: Emit a signal to the that the player is dead
