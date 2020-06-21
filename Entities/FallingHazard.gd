extends "res://Entities/DownFallingHazard.gd"

export var gravity_factor = 0.2

func _ready():
	PlayerVariables.connect("gravity_changed", self, "_on_Player_gravity_changed")
	
	gravity_vector = PlayerVariables.gravity * gravity_factor
	
func _on_Player_gravity_changed(new_gravity):
	gravity_vector = new_gravity * gravity_factor
