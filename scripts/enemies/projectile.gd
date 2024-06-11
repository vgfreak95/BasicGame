class_name Projectile
extends Area2D

signal hit

@onready var screen_size = get_viewport_rect().size

@export var speed = 200
@export var velocity = Vector2()
@export var damage = 10


func _process(delta):
	# Move the projectile
	position += velocity * speed * delta

	#TODO: Add Dampening here later


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body: Node2D):
	if body as Player != null:
		print("From projectile: Hit PLAYER")
		emit_signal("hit", damage)
