class_name HealthPickup
extends Pickup

@export var to_heal: int = 20


func on_pickup(player):
	player.heal(to_heal)
