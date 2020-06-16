tool
extends KinematicBody2D

const SPIKE_WIDTH = 27
const SPIKE_HEIGHT = 18

export var number_of_spikes = 1 setget set_size

func set_size(new_size):
	number_of_spikes = new_size
	$CollisionShape2D.set_shape($CollisionShape2D.get_shape().duplicate(true))
	$CollisionShape2D.get_shape().set_extents(Vector2(SPIKE_WIDTH * number_of_spikes / 2, SPIKE_HEIGHT / 2))
	$TextureRect.rect_size = Vector2(SPIKE_WIDTH * number_of_spikes, SPIKE_HEIGHT)
	$TextureRect.rect_position = Vector2(-SPIKE_WIDTH * number_of_spikes / 2, -SPIKE_HEIGHT / 2)

export var damage = 1 setget set_damage, get_damage

func set_damage(new_damage):
	damage = new_damage
	
func get_damage():
	return damage

