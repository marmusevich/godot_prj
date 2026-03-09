@tool
extends EditorScript

func _run():
	var sel = get_editor_interface().get_selection().get_selected_nodes()

	if sel.size() == 0:
		push_error("No node selected")
		return
	
	var root_node = sel[0]
	if root_node.name != Editor_MapIO.ROOT_MAP_NODE_NAME:
		push_error("No selection root MAP node")
		return
		
	var dialog := EditorFileDialog.new()
	dialog.file_mode = EditorFileDialog.FILE_MODE_OPEN_FILE
	dialog.access = EditorFileDialog.ACCESS_RESOURCES
	dialog.current_dir = &"res://presentation/tactical"
	dialog.filters = ["*.map.tres ; Tile map data"]

	dialog.file_selected.connect(
		func(path):
			_confirm_and_load(root_node, path)
			dialog.queue_free()
	)

	get_editor_interface().get_base_control().add_child(dialog)
	dialog.popup_centered()


func _confirm_and_load(root_node: Node2D, path: String):
	var confirm = ConfirmationDialog.new()
	confirm.dialog_text = "All layers data will reload, continue?"

	confirm.confirmed.connect(
		func():
			print("Load map from :", path)
			var map :TacticalMapDefinition = ResourceLoader.load(path)
			Editor_MapIO.build_root_node_from_res(root_node, map)
			confirm.queue_free()
	)

	confirm.canceled.connect(
		func():
			confirm.queue_free()
	)

	get_editor_interface().get_base_control().add_child(confirm)
	confirm.popup_centered()
