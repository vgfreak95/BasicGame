class_name HPComponent
extends Node2D

signal on_death

@export var max_health: int = 100
@export var min_health: int = 0
@export var current_health: int = 100

@onready var is_dead: bool = false


func lose_health(damage):
	current_health -= damage
	if current_health <= 0 and not is_dead:
		current_health = 0
		emit_signal("on_death")
		is_dead = true


func restore_health(health_to_restore: int):
	current_health += health_to_restore
	if current_health >= max_health:
		current_health = max_health
