extends BaseScene


@onready var options_menu := preload("res://modes/common/ui/options_menu.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()

	options_menu.manager = submenu_manager
	submenu_manager.stack_root.add_child(options_menu)
	options_menu.visible = false


func _on_primary_button_activated(id: StringName) -> void:
	print("main menu::_on_primary_button_activated ID = ", id)
	match id:
		"start":
			pass
		"load":
			pass
		"option":
			submenu_manager.push(options_menu)
		"quit":
			pass
			
		_:
			# Знак подчеркивания работает как "default"
			push_warning("Неизвестный ID кнопки: ", id)
