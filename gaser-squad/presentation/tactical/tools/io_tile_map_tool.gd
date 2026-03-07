class_name Editor_MapIO extends Object

# TacticalMapDefinition


const ROOT_MAP_NODE_NAME: StringName = &"TacticalMap"

const SPAWN_LAYER_NAME: StringName = &"_SpawnPlaces"
const SPAWN_LAYER_ID_TEAM_1: StringName = &"team 1"
const SPAWN_LAYER_ID_TEAM_2: StringName = &"team 2"
const SPAWN_LAYER_ID_ITEM: StringName = &"item" 



## save tile map
static func build_res_from_root_node(root :Node) -> TacticalMapDefinition:
	var map :TacticalMapDefinition
	
	var map_def_tmp = root.get("map_definition")
	if map_def_tmp and map_def_tmp is TacticalMapDefinition:
		print("Map Definition: ", map_def_tmp)
		map = map_def_tmp
	else:
		print("Переменная пуста или не найдена")
		map = TacticalMapDefinition.new()
	
	if not map.tile_db:
		map.tile_db = TacticalTileDatabase.new()
	
	map.tile_db._init()
	
	#enumerate ala children and save  TileMapLayer
	for layer in root.get_children():
		if not layer is TileMapLayer:
			continue
		
		if layer.name == SPAWN_LAYER_NAME:
			_save_spawn_place(map, layer)
			continue
		
		map.layer = _make_layer_def(map, layer)
	
	return map
	pass



static func build_root_node_from_res(root:Node2D, map:TacticalMapDefinition):
	pass





#########################################################################################
#saves

#special case - save direct in map
static func _save_spawn_place(map :TacticalMapDefinition, spawn_layer :TileMapLayer):
	if not map.posible_spawn_pos_team_1 :
		map.posible_spawn_pos_team_1 = []
	if not map.posible_spawn_pos_team_2 :
		map.posible_spawn_pos_team_2 = []
	if not map.posible_spawn_pos_item :
		map.posible_spawn_pos_item = []
	
	for pos in spawn_layer.get_used_cells():
		var source = spawn_layer.get_cell_source_id(pos)
		if source == -1:
			continue
		
		var tile_data = spawn_layer.get_cell_tile_data(pos)
		if tile_data == null:
			continue
		
		var tile_id = tile_data.get_custom_data("IDs")
		if tile_id == null:
			push_error("Tile without tile_id at %s" % pos)
			continue
		
		match tile_id:
			SPAWN_LAYER_ID_TEAM_1:
				if not map.posible_spawn_pos_team_1.has(pos) :
					map.posible_spawn_pos_team_1.push_back(pos)
			SPAWN_LAYER_ID_TEAM_2:
				if not map.posible_spawn_pos_team_2.has(pos) :
					map.posible_spawn_pos_team_2.push_back(pos)
			SPAWN_LAYER_ID_ITEM:
				if not map.posible_spawn_pos_item.has(pos) :
					map.posible_spawn_pos_item.push_back(pos)
			
			_:
				push_warning("Unexpected tile_id '&s' at [%s]" % tile_id, pos)



# make layer def
static func _make_layer_def(map :TacticalMapDefinition, layer :TileMapLayer) -> TacticalLayerDefinition:
	var ld : TacticalLayerDefinition = TacticalLayerDefinition.new()
	ld.tile_set = layer.tile_set
	ld.name = layer.name
	
	for pos in layer.get_used_cells():
		var source = layer.get_cell_source_id(pos)
		if source == -1:
			continue
		
		var tile_data = layer.get_cell_tile_data(pos)
		if tile_data == null:
			continue
		
		var tile_id = tile_data.get_custom_data("IDs")
		if tile_id == null:
			push_error("Tile without tile_id at %s" % pos)
			continue
		
		if not map.tile_db.has_tile(tile_id):
			push_error("Tile id '%s' not in database" % tile_id)
			var tile_def_temp: TacticalTileDefinition = TacticalTileDefinition.new()
			tile_def_temp.id = tile_id
			tile_def_temp.name = "NEED EDIT"
			
			map.tile_db.add_tile(tile_def_temp)
			continue
		
		
	
	
	
	return ld











#static func build_resource_from_layer(layer:TacticalLayerDefinition, db:TacticalTileDatabase) -> MapResource:

#	var res := MapResource.new()

#	res.tile_set = layer.tile_set
#	res.cells = []

#	var used = layer.get_used_cells()

#	for pos in used:

#		var source = layer.get_cell_source_id(pos)

#		if source == -1:
#			continue

#		var tile_data = layer.get_cell_tile_data(pos)

#		if tile_data == null:
#			continue

#		var tile_id = tile_data.get_custom_data("tile_id")

#		if tile_id == null:
#			push_error("Tile without tile_id at %s" % pos)
#			continue

#		if not db.has_tile(tile_id):
#			push_error("Tile id %d not in database" % tile_id)
#			continue

#		var c := CellData.new()

#		c.position = pos
#		c.tile_id = tile_id

#		res.cells.append(c)

#	return res


#static func apply_resource_to_layer(map:MapResource, layer:TacticalLayerDefinition):
#
	#layer.clear()
	#layer.tile_set = map.tile_set
#
	#for cell in map.cells:
#
		#var pos = cell.position
		#var id = cell.tile_id
#
		## ищем tile в tileset
		#for source_id in layer.tile_set.get_source_count():
#
			#var source = layer.tile_set.get_source(source_id)
#
			#if source is TileSetAtlasSource:
#
				#for coord in source.get_tiles_ids():
#
					#var data = source.get_tile_data(coord,0)
#
					#if data and data.get_custom_data("tile_id") == id:
#
						#layer.set_cell(pos, source_id, coord)
#
						#break
