extends Area2D


@export var current_speed = 200
var walk_speed = 200
var run_speed = 400
var screen_size

@onready var player_animation = $AnimatedPlayer2D
@onready var sword_animation = $SpriteSword2D

# Called when the node enters the scene tree for the first time.
func _ready():
  screen_size = get_viewport_rect().size


func _process(delta):
  var velocity = Vector2.ZERO

  # Processing user input
  if Input.is_action_pressed("move_down"):
    velocity.y += 1
  if Input.is_action_pressed("move_up"):
    velocity.y -= 1
  if Input.is_action_pressed("move_left"):
    # $AnimatedSprite2D.flip_h = true
    player_animation.flip_h = true
    sword_animation.flip_h = true
    velocity.x -= 1
  if Input.is_action_pressed("move_right"):
    # $AnimatedSprite2D.flip_h = false
    player_animation.flip_h = false
    sword_animation.flip_h = false
    velocity.x += 1


  # Player sprinting
  if Input.is_action_pressed("run"):
    current_speed = run_speed
    # $AnimatedSprite2D.speed_scale = 1.5
    player_animation.speed_scale = 1.5
  if Input.is_action_just_released("run"):
    current_speed = walk_speed
    player_animation.speed_scale = 1.00
    # $AnimatedSprite2D.speed_scale = 1.00
  

  # When the player has stopped pressing buttons/moving
  if velocity.length() > 0:
    velocity = velocity.normalized() * current_speed
    # $AnimatedSprite2D.play()
    player_animation.play()
  else:
    # $AnimatedSprite2D.stop()
    player_animation.stop()

  position += velocity * delta
  position = position.clamp(Vector2.ZERO, screen_size)
