extends BaseScene

@onready var options_menu := preload("res://modes/common/ui/options_menu.tscn").instantiate()

func _ready() -> void:
	super._ready()
	
	options_menu.manager = submenu_manager
	submenu_manager.stack_root.add_child(options_menu)
	options_menu.visible = false
	

func _on_all_menus_closed():
	pass
	# todo - return focus
	# see _grab_focus_safely from SubMenuManager


func _on_primary_button_activated(id: UIIds.ButtonId) -> void:
	match id:
		UIIds.ButtonId.MAIN_PLAY:
			SceneManager.change_scene(SceneManager.start_gama_scene)
		UIIds.ButtonId.MAIN_LOAD:
			pass
		UIIds.ButtonId.MAIN_OPTIONS:
			submenu_manager.push(options_menu)
		UIIds.ButtonId.MAIN_EXIT:
			SceneManager.quit_game()
		_:
			push_warning("main menu::_on_primary_button_activated: wrong ID - ", id)
	
