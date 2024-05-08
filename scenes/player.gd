extends Area2D


# Player Specific Informa
@export var current_speed = 200
var walk_speed = 200
var run_speed = 400
var screen_size
var is_sword_changed = false
@onready var player_animation = $AnimatedPlayer2D


# Sword Specific Information
@onready var sword_sprite = $SpriteSword2D 
 
func flip_horizontal(direction: bool):
  var nodes_to_flip = [player_animation, sword_sprite]

  for node in nodes_to_flip:
    node.flip_h = direction

func change_sword_position(direction: bool):
  
  # Facing Left
  if direction:
    var new_x_pos = (player_animation.position.x + 15)
    sword_sprite.set_position(Vector2(new_x_pos, sword_sprite.get_position().y))
    sword_sprite.set_rotation(160.0)

  # Facing Right
  else:
    var new_x_pos = (player_animation.position.x - 15)
    sword_sprite.set_position(Vector2(new_x_pos, sword_sprite.get_position().y))
    sword_sprite.set_rotation(-160.0)

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
    flip_horizontal(true)
    change_sword_position(true)
    velocity.x -= 1

  if Input.is_action_pressed("move_right"):
    flip_horizontal(false)
    change_sword_position(false)
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
