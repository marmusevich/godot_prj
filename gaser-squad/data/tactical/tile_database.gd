class_name TacticalTileDatabase extends Resource

@export var tiles : Array[TacticalTileDefinition]

var _map : Dictionary[StringName, TacticalTileDefinition] = {}

func _init():
	_rebuild()

func _rebuild():
	_map.clear()

	for t in tiles:
		if _map.has(t.id):
			push_error("Duplicate tile id: %d" % t.id)
		
		_map[t.id] = t


func has_tile(id :StringName) -> bool:
	return _map.has(id)


func get_tile(id :StringName) -> TacticalTileDefinition:
	return _map.get(id)


func add_tile(tile_def: TacticalTileDefinition):
	if _map.has(tile_def.id):
		push_error("Duplicate tile id: %d" % tile_def.id)
		return
	
	_map[tile_def.id] = tile_def
	tiles.push_back(tile_def)
	
