extends Node2D

@onready var sword = $Sprite2D
@onready var animation = $AnimationPlayer


func use_weapon():
	var player = get_parent()
	var left = player.get_node("LeftSide")
	var right = player.get_node("RightSide")

	var cursor_position = get_global_mouse_position()
	var player_position = player.position

	if not animation.is_playing():
		if cursor_position > player_position:
			position = right.position
			animation.play("right_swing_down")
		if cursor_position < player_position:
			position = left.position
			animation.play("left_swing_down")


func render_weapon():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
