extends BaseScene


@onready var options_menu := preload("res://modes/common/ui/options_menu.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()

	options_menu.manager = submenu_manager
	submenu_manager.stack_root.add_child(options_menu)
	options_menu.visible = false



func _on_btn_start_pressed() -> void:
	pass # Replace with function body.


func _on_btn_load_pressed() -> void:
	pass # Replace with function body.


func _on_btn_option_pressed() -> void:
	submenu_manager.push(options_menu)

func _on_btn_exit_pressed() -> void:
	pass # Replace with function body.
