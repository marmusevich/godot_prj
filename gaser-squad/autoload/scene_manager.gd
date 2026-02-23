extends Node

# ==============================
# Scene IDs (публичные)
# ==============================

const MAIN_MENU: StringName = &"main_menu"
const TACTICAL_MAIN: StringName = &"tactical_main"

## name of start game scene - only for debug ?
var start_gama_scene: StringName = TACTICAL_MAIN


# ==============================
# Словарь сцен
# ==============================

var _scenes: Dictionary[StringName, String] = {
	MAIN_MENU: "res://modes/main_menu/main_menu.tscn",
	TACTICAL_MAIN: "res://modes/tactical/tactical_main.tscn",
	
}

# 
var _current_scene: Node = null
var _root: Node
var _fade_layer: CanvasLayer
var _fade_rect: ColorRect
var _fade_tween: Tween



# ==============================
# Публичный API
# ==============================

func change_scene(scene_id: StringName) -> void:
	if not _scenes.has(scene_id):
		push_error("Scene ID not found: %s" % scene_id)
		return
	
	print("Changing scene to: ", scene_id)

	await _fade_out()

	var packed: PackedScene = load(_scenes[scene_id])
	var new_scene = packed.instantiate()

	if _current_scene:
		_current_scene.queue_free()

	_root.add_child(new_scene)
	_current_scene = new_scene

	await _fade_in()

func quit_game() -> void:
	_show_quit_confirmation()


func register_root(node: Node) -> void:
	_root = node
	_create_fade_layer()



# ==============================


func _create_fade_layer() -> void:
	# CanvasLayer
	_fade_layer = CanvasLayer.new()
	_fade_layer.layer = 100   # гарантированно поверх
	_root.add_child(_fade_layer)
	
	# ColorRect
	_fade_rect = ColorRect.new()
	_fade_rect.color = Color.BLACK
	_fade_rect.modulate.a = 0.0
	_fade_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_fade_rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	
	_fade_layer.add_child(_fade_rect)
	


func _kill_fade_tween():
	if _fade_tween:
		if _fade_tween.is_running():
			_fade_tween.kill()
		_fade_tween = null
	


func _fade_out(duration: float = 0.4) -> void:
	_kill_fade_tween()

	_fade_tween = create_tween()
	_fade_tween.set_trans(Tween.TRANS_SINE)
	_fade_tween.set_ease(Tween.EASE_IN_OUT)

	_fade_tween.tween_property(
		_fade_rect,
		"modulate:a",
		1.0,
		duration
	)

	await _fade_tween.finished
	


func _fade_in(duration: float = 0.4) -> void:
	_kill_fade_tween()

	_fade_tween = create_tween()
	_fade_tween.set_trans(Tween.TRANS_SINE)
	_fade_tween.set_ease(Tween.EASE_IN_OUT)

	_fade_tween.tween_property(
		_fade_rect,
		"modulate:a",
		0.0,
		duration
	)

	await _fade_tween.finished
	

func _show_loading_screen():
	print("Show loading screen...")

func _hide_loading_screen():
	print("Hide loading screen...")

func _show_quit_confirmation():
	var dialog := ConfirmationDialog.new()
	dialog.title = "Exit"
	dialog.dialog_text = "Are you sure you want to quit?"
	dialog.confirmed.connect(_on_quit_confirmed)
	
	get_tree().root.add_child(dialog)
	dialog.popup_centered()

func _on_quit_confirmed():
	get_tree().quit()
