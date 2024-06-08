extends RigidBody2D

var screen_size
var can_destroy: bool = false

@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.position.x > screen_size.x or self.position.x < 0 and can_destroy:
		queue_free()
	if self.position.y > screen_size.y or self.position.y < 0 and can_destroy:
		queue_free()

func _on_timer_timeout():
	can_destroy = true
