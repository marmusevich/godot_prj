@tool
extends EditorScript

@export_file("*.xml") var xml_path : String =   "res://assets/ui/common/kenney_ui-pack-space-expansion/uipackSpace_sheet.xml"
@export_file("*.png") var atlas_path : String = "res://assets/ui/common/kenney_ui-pack-space-expansion/uipackSpace_sheet.png"
@export_dir var output_dir : String =           "res://assets/ui/common/kenney_ui-pack-space-expansion"


func _run():
	var xml := XMLParser.new()
	if xml.open(xml_path) != OK:
		push_error("Cannot open XML")
		return

	var atlas := load(atlas_path)

	while xml.read() == OK:
		if xml.get_node_type() == XMLParser.NODE_ELEMENT \
		and xml.get_node_name() == "SubTexture":

			var name := xml.get_named_attribute_value("name")
			var x := int(xml.get_named_attribute_value("x"))
			var y := int(xml.get_named_attribute_value("y"))
			var w := int(xml.get_named_attribute_value("width"))
			var h := int(xml.get_named_attribute_value("height"))

			var at := AtlasTexture.new()
			at.atlas = atlas
			at.region = Rect2(x, y, w, h)

			var out_path := output_dir.path_join(name.replace(".png", ".tres"))

			ResourceSaver.save(at, out_path)

	print("Atlas XML imported into AtlasTexture resources")
