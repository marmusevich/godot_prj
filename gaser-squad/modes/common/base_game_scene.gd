class_name BaseGameScene extends BaseScene


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		_show_quit_confirmation()
	# it must be pause menu
		




# copy paste, see: Scene_manager.gd
#TODO provide custom confirm dialog
func _show_quit_confirmation():
	var dialog := ConfirmationDialog.new()
	dialog.title = "Exit"
	dialog.dialog_text = "Are you sure you want to exit to Main Menu?"
	dialog.confirmed.connect(_on_quit_confirmed)
	
	get_tree().root.add_child(dialog)
	dialog.popup_centered()

func _on_quit_confirmed():
	SceneManager.change_scene(SceneManager.MAIN_MENU)
