extends KinematicBody2D

export var damage = 1 setget set_damage, get_damage

func set_damage(new_damage):
	damage = new_damage
	
func get_damage():
	return damage

