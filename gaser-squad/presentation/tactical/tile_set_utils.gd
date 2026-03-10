extends RefCounted
class_name TileSetUtils


const CUSTOM_LAYER_NAME : StringName = &"IDs"

# Internal helper structure describing one tile inside TileSet
# Внутренняя структура описывающая один тайл внутри TileSet
class TileInfo:
	var source_id : int
	var coord : Vector2i
	var alt_id : int
	var custom_id : StringName
	var is_scene : bool



## -------------------------------------------------------------------
## iterate_all_tiles
##
## EN:
## Iterates through ALL tiles in a TileSet and calls a callback for each tile.
## The callback receives a TileInfo structure.
##
## This function is useful for:
##  - building tile databases
##  - validating custom tile IDs
##  - debugging TileSets
##
##
## RU:
## Итерируется по ВСЕМ тайлам в TileSet и вызывает callback для каждого тайла.
## Callback получает структуру TileInfo.
##
##
## Функция полезна для:
##  - построения базы тайлов
##  - проверки уникальности пользовательских ID
##  - отладки TileSet
##
##
## Parameters / Параметры
##
## tile_set : TileSet
##      TileSet для обхода
##
## callback : Callable
##      Lambda / function that will be called for every tile.
##      Receives parameters:
##
##          func( tile_info : TileInfo)
##
##      tile_info
##          Structure describing tile properties
##
## custom_layer_name : String
##      Name of TileSet Custom Data Layer used to read tile ID
##      Default: "IDs"
##
## -------------------------------------------------------------------
static func iterate_all_tiles(
		tile_set : TileSet,
		callback : Callable,
		custom_layer_name : StringName = CUSTOM_LAYER_NAME
	) -> void:

	if tile_set == null:
		push_error("TileSetUtils.iterate_all_tiles(): tile_set is null")
		return

	if callback == null or not callback.is_valid():
		push_error("TileSetUtils.iterate_all_tiles(): callback is null or invalid")
		return

	for source_idx in tile_set.get_source_count():
		var source_id = tile_set.get_source_id(source_idx)
		var source = tile_set.get_source(source_id)
		if source == null:
			continue

		for i in range(source.get_tiles_count()):
			var coord = source.get_tile_id(i)
			var alt_count = source.get_alternative_tiles_count(coord)
			for alt_index in range(alt_count):
				var alt_id = source.get_alternative_tile_id(coord, alt_index)
				var tile_data = source.get_tile_data(coord, alt_id)
				var custom_id = null

				if tile_data:
					custom_id = tile_data.get_custom_data(custom_layer_name)

				var info = TileInfo.new()
				info.source_id = source_id
				info.coord = coord
				info.alt_id = alt_id
				info.custom_id = custom_id
				info.is_scene = source is TileSetScenesCollectionSource

				callback.call(info)
