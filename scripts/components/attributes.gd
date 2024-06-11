extends Node2D

@export var attributes = {strength = 0, intelligence = 0, dexterity = 0}

var max_strength: int = 100
var max_intelligence: int = 100
var max_dexterity: int = 100

var strength: int
var intelligence: int
var dexterity: int


# Setters
func set_strength(new_strength):
	attributes.strength = new_strength


func set_intelligence(new_intelligence):
	attributes.intelligence = new_intelligence


func set_dexterity(new_dexterity):
	attributes.dexterity = new_dexterity


func set_attributes(new_strength: int, new_intelligence: int, new_dexterity: int):
	attributes = {
		strength = new_strength, intelligence = new_intelligence, dexterity = new_dexterity
	}


# Getters
func get_strength():
	return attributes.strength


func get_intelligence():
	return attributes.intelligence


func get_dexterity():
	return attributes.dexterity


func get_attributes():
	return attributes


func _init():
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
