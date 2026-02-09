class_name BaseScene
extends Node


var submenu_manager: SubMenuManager

func _ready():
	_create_submenu_manager()
	_connect_signals()

func _create_submenu_manager():
	submenu_manager = SubMenuManager.new()
	add_child(submenu_manager)

func _connect_signals():
	submenu_manager.stack_empty.connect(_on_all_menus_closed)

# Переопределяется в наследниках
func _on_all_menus_closed():
	pass
	# todo - return focus
	# see _grab_focus_safely from SubMenuManager
