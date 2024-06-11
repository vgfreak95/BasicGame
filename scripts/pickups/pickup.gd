class_name Pickup
extends Area2D

signal picked_up(player)


func _on_body_entered(body: Node2D):
	if body as Player != null:
		emit_signal("picked_up", body)
		on_pickup(body)
		queue_free()


# Override this functionality in subclass
func on_pickup(player):
	pass
