class_name SomePickup
extends "res://scripts/pickups/pickup.gd"

@export var class_type = TYPE_OBJECT


func on_pickup(player):
	print("Picked up")
