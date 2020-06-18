extends Control

func _input(event):
	if event.is_action_pressed("ui_left"):
		PlayerVariables.choose_character("Lefty")
	elif event.is_action_pressed("ui_right"):
		PlayerVariables.choose_character("Righty")
	elif event.is_action_pressed("ui_up"):
		PlayerVariables.choose_character("God")
