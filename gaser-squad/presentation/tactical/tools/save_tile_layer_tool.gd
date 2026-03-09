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
	dialog.file_mode = EditorFileDialog.FILE_MODE_SAVE_FILE
	dialog.access = FileDialog.ACCESS_RESOURCES
	dialog.current_dir=&"res://presentation/tactical"
	dialog.filters = ["*.map.tres ; Tile map data"]

	dialog.file_selected.connect(func(path):
		var map  = Editor_MapIO.build_res_from_root_node(root_node)
		
		ResourceSaver.save(map, path)
		print("Saved map to :", path)
		dialog.queue_free()
	)

	get_editor_interface().get_base_control().add_child(dialog)
	dialog.popup_centered()

	
