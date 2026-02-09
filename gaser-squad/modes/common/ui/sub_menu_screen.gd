class_name SubMenuScreen
extends Control


@export var manager: SubMenuManager

func close():
	manager.pop()

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		close()
		get_viewport().set_input_as_handled()
