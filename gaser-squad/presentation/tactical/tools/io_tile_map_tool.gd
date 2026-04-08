class_name Editor_MapIO
extends RefCounted

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
		print("Map Definition set and used: ", map_def_tmp)
		map = map_def_tmp
	else:
		print("TacticalMapDefinition not set - created")
		map = TacticalMapDefinition.new()

	if not map.tile_db:
		map.tile_db = TacticalTileDatabase.new()

	map.tile_db._rebuild()

	#enumerate ala children and save  TileMapLayer
	for layer in root.get_children():
		if not layer is TileMapLayer:
			continue

		if layer.name == SPAWN_LAYER_NAME:
			_save_spawn_place(map, layer)
			continue

		map.layer = _make_layer_def(map, layer)

	return map
	



static func build_root_node_from_res(root:Node2D, map:TacticalMapDefinition):
	if not map.tile_db:
		push_error("tile DB EMPTY, can't load")
		return
		
	root.set("map_definition", map)

	# clear / destroy layers ?

	# create or redefine layer
	# use map.layer
	
	var layer :TileMapLayer = _make_layer_from_def(map.tile_db, map.layer)
	if not layer :
		root.add_child(layer)


#var spawn_layer := TileMapLayer.new()
#spawn_layer.name = SPAWN_LAYER_NAME
#
## 1. Обязательно назначьте TileSet, иначе слой не сможет хранить тайлы
#spawn_layer.tile_set = map.tile_set 
#
## 2. Добавьте к родителю
#root.add_child(spawn_layer, true) # true = force_readable_name
#
## 3. Заполните данными
#_load_spawn_place(map, spawn_layer)
#
## 4. ВАЖНО: Для сохранения в сцену (если это инструмент редактора)
#if Engine.is_editor_hint():
	#spawn_layer.set_owner(root) 
	# 3. Обновляем UI редактора
	#editor_interface.get_scene_tree_dock().update_tree()
	
	
	
	
	
#-----------------------------------------------------------------------
	## 1. Загружаем TileSet
	#var tile_set := load(tile_set_path) as TileSet
	#
	#if not tile_set:
		#push_error("TileSet not found at: %s" % tile_set_path)
		#return null


#@tool
#func create_spawn_layer(root: Node, source_tilemap: TileMap) -> TileMapLayer:
	## Проверка на существование, чтобы не дублировать
	#var existing = root.get_node_or_null(SPAWN_LAYER_NAME)
	#if existing:
		#push_warning("Spawn layer already exists!")
		#return existing
	#
	#var spawn_layer := TileMapLayer.new()
	#spawn_layer.name = SPAWN_LAYER_NAME
	#
	## Копируем настройки тайлсета
	#if source_tilemap and source_tilemap.tile_set:
		#spawn_layer.tile_set = source_tilemap.tile_set
	#else:
		#push_error("No TileSet found! Layer will be empty.")
	#
	## Добавляем в сцену
	#root.add_child(spawn_layer, true)
	#
	## Настраиваем владельца для сохранения (только в редакторе)
	#if Engine.is_editor_hint():
		#spawn_layer.set_owner(root)
		#
		## Уведомляем редактор об изменениях в сцене
		## Это нужно, чтобы кнопка "Сохранить" активировалась
		#var editor_interface = get_editor_interface()
		#if editor_interface:
			#editor_interface.get_scene_tree_dock().update_tree()
	#
	#return spawn_layer



	# not (null and empty)
	if 	not (map.posible_spawn_pos_team_1 and map.posible_spawn_pos_team_1.is_empty()) or not (map.posible_spawn_pos_team_2 and map.posible_spawn_pos_team_2.is_empty()) or not (map.posible_spawn_pos_item and map.posible_spawn_pos_item.is_empty()) :
		#create or redefine spawn layer
		var spawn_layer :TileMapLayer = TileMapLayer.new()
		spawn_layer.name = SPAWN_LAYER_NAME
		_load_spawn_place(map, spawn_layer)



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
				push_warning("Unexpected tile_id '&s' at [%s]" % [tile_id, pos])

static func _load_spawn_place(map :TacticalMapDefinition, spawn_layer :TileMapLayer):
	pass

# make layer def
static func _make_layer_def(map :TacticalMapDefinition, layer :TileMapLayer) -> TacticalLayerDefinition:
	var ld : TacticalLayerDefinition = TacticalLayerDefinition.new()
	ld.tile_set = layer.tile_set
	ld.name = layer.name
	ld.layer_type = TacticalLayerDefinition.LayerType.TERRAIN


	#prepare tile set
	var for_find_dubl_ids := {}
	TileSetUtils.iterate_all_tiles(ld.tile_set, func(info):
		#print("%d_(%d_%d)_%d - %s" % [
					#info.source_id,
					#info.coord.x,
					#info.coord.y,
					#info.alt_id,
					#info.custom_id
				#])

		if info.custom_id == null:
			return

		# check dublckates
		if for_find_dubl_ids.has(info.custom_id):
			push_error("Duplicate tile id: ", info.custom_id)
			return
		else:
			for_find_dubl_ids[info.custom_id] = true

		# add not presend in DB to DB
		if not map.tile_db.has_tile(info.custom_id):
			push_warning("Tile id '%s' not in database" % info.custom_id)
			var tile_def_temp: TacticalTileDefinition = TacticalTileDefinition.new()
			tile_def_temp.id = info.custom_id
			tile_def_temp.display_name = "NEED EDIT " + info.custom_id
			map.tile_db.add_tile(tile_def_temp)
	)
	# sort
	map.tile_db.tiles.sort_custom(func(a, b):
		return String(a.id) < String(b.id)
		)
		
	#---------------------------------------

	#prepare tiles
	for pos in layer.get_used_cells():
		var source = layer.get_cell_source_id(pos)
		if source == -1:
			continue

		var tile_data = layer.get_cell_tile_data(pos)
		if tile_data == null:
			continue

		# get custom tile id
		var tile_id = tile_data.get_custom_data(TileSetUtils.CUSTOM_LAYER_NAME)
		if tile_id == null:
			push_error("Tile without tile_id at %s" % pos)
			return null

		# if not presed ID in DB
		if not map.tile_db.has_tile(tile_id):
			push_error("Tile id '%s' not in database" % tile_id)
			return null

		# store tile data
		var tile_ref : = InLayerTileReferenceDefinition.new()
		tile_ref.tile_pos = pos
		tile_ref.tile_id = tile_id
		ld.tile_ids.push_back(tile_ref)

	return ld




#static func apply_resource_to_layer(map:MapResource, layer:TacticalLayerDefinition):
	#layer.clear()
	#layer.tile_set = map.tile_set
	#for cell in map.cells:
#
		#var pos = cell.position
		#var id = cell.tile_id
		## ищем tile в tileset
		#for source_id in layer.tile_set.get_source_count():
			#var source = layer.tile_set.get_source(source_id)
			#if source is TileSetAtlasSource:
				#for coord in source.get_tiles_ids():
					#var data = source.get_tile_data(coord,0)
					#if data and data.get_custom_data("tile_id") == id:
						#layer.set_cell(pos, source_id, coord)
						#break



static func _make_layer_from_def(tile_db :TacticalTileDatabase, ld :TacticalLayerDefinition) -> TileMapLayer:
	return null
	
	#clear()
	#
	#for y in range(map.size()):
		#for x in range(map[y].size()):
			#if map[y][x] == 1:
				#set_cell(Vector2i(x, y), 0, TILE_WALL)
			#if map[y][x] == 2:
				#set_cell(Vector2i(x, y), 0, TILE_START_POINT)
			#if map[y][x] == 3:
				#set_cell(Vector2i(x, y), 0, TILE_END_POINT)	
