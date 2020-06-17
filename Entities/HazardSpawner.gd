extends Node2D

export (NodePath) var hazard_node_path
export var first_spawn_offset = 0.0
export var spawn_wait = 2.0

var first_shot = true
var hazard

func _ready():
	hazard = get_node(hazard_node_path)
	
	hazard.position = position
	hazard.hide()
	hazard.set_process(false)
	
	$Timer.connect("timeout", self, "_on_Timer_timeout")
	hazard.connect("destroyed", $Timer, "start")
	
	if (first_spawn_offset <= 0):
		spawn()
		first_shot = false
	else:
		$Timer.start(first_spawn_offset);

func _on_Timer_timeout():
	print("timeout")
	if first_shot:
		$Timer.wait_time = spawn_wait
		first_shot = false
	
	spawn()

func spawn():
	hazard.position = position
	hazard.set_process(true)
	hazard.restart()
