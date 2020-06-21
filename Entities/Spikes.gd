tool
extends "HazardBase.gd"

const SPIKE_WIDTH = 27
const SPIKE_HEIGHT = 18

export var number_of_spikes = 1 setget set_size

func set_size(new_size):
	number_of_spikes = new_size	
	$Shape.set_shape($Shape.get_shape().duplicate(true))
	$Shape.get_shape().set_extents(Vector2(SPIKE_WIDTH * number_of_spikes / 2, SPIKE_HEIGHT / 2))
	
	for node in get_children():
		if node is TextureRect:	
			node.rect_size = Vector2(SPIKE_WIDTH * number_of_spikes, SPIKE_HEIGHT)
			node.rect_position = Vector2(-SPIKE_WIDTH * number_of_spikes / 2, -SPIKE_HEIGHT / 2)
