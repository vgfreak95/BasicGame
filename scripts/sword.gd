extends Weapon

@onready var sword = $Sprite2D
@onready var animation = $AnimationPlayer

var is_facing_right: bool = true
@export var offset: int = 25


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


func use_weapon():
	print("Used weapon")
	animation.play("stab")


func render_weapon(player_position: Vector2):
	var cursor_position = get_viewport().get_mouse_position()
	var angle = rad_to_deg(sword.global_position.angle_to_point(cursor_position))
	# print(angle)
	# sword.rotation_degrees = angle
	# -90 and 90 clamp 30 and -30
# sword.global_position.x = player_position.x

# Change sword location on character
	if cursor_position.x > player_position.x:
		# sword.flip_v = false
		sword.global_position.x = player_position.x + offset
		angle = clamp(-30, angle, 30)

	elif cursor_position.x < player_position.x:
		# sword.flip_v = true
		sword.global_position.x = player_position.x + offset
		if angle < 0:
			angle = clamp(-180, angle, -150)
			# angle += 180
		else:
			# angle -= 180
			angle = clamp(150, angle, 180)  # Clamp angle within the desired range

# angle = clamp(-140, angle, 140)
# angle = clamp(-30, angle, 30)
	sword.rotation_degrees = angle


# var angle_to_cursor = (cursor_position - player_position).angle()

# sword.rotation_degrees = angle
# Convert angle to degrees and adjust for sprite rotation offset
# var rotation_degrees = rad_to_deg(angle_to_cursor)  # Adjust the offset as needed
# rotation_degrees = clamp(4, rotation_degrees, 40)
# print(angle)

# Set sword rotation
# sword.rotation_degrees = rotation_degrees


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
