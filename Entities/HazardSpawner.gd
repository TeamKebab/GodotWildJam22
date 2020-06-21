extends Node2D

export (NodePath) var hazard_node_path
export var first_spawn_offset = 0.0
export var spawn_wait = 2.0

var first_shot = true
var hazard
var timer

func _ready():
	hazard = get_node(hazard_node_path)
	timer = find_node("Timer")
	
	hazard.position = position
	hazard.hide()
	hazard.set_process(false)
			
	timer.connect("timeout", self, "_on_timer_timeout")
	hazard.connect("destroyed", self, "_on_hazard_destroyed")
	
	if (first_spawn_offset <= 0):
		spawn()
		first_shot = false
	else:
		timer.start(first_spawn_offset);

func _on_hazard_destroyed():
	timer.start()
	
func _on_timer_timeout():	
	if first_shot:
		timer.wait_time = spawn_wait
		first_shot = false
	
	spawn()

func spawn():
	hazard.position = position
	hazard.restart()
