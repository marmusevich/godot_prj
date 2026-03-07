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

	#var td: TacticalMapDefinition = root_node.
	
	#var script = root_node.get_script()
#
	## Проверяем, существует ли скрипт и является ли он нужным нам классом
	#if script and script.resource_path.ends_with("my_script.gd"): 
		## Или если у вас есть ссылка на класс: if script == MyCustomScript:
		#var map_def = node.get("map_definition")
		#print("Найдено: ", map_def)
	#else:
		#print("У ноды нет нужного скрипта")

	
	var dialog := EditorFileDialog.new()
	dialog.file_mode = EditorFileDialog.FILE_MODE_SAVE_FILE
	dialog.access = FileDialog.ACCESS_RESOURCES
	dialog.current_dir=&"res://presentation/tactical"
	dialog.filters = ["*.tres ; Tile map data"]

	dialog.file_selected.connect(func(path):
		var map  = Editor_MapIO.build_res_from_root_node(root_node)
		
		ResourceSaver.save(map, path)
		print("Saved map to :", path)
		dialog.queue_free()
	)

	get_editor_interface().get_base_control().add_child(dialog)
	dialog.popup_centered()

	
