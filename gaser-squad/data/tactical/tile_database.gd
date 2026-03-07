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


func has_tile(id:int) -> bool:
	return _map.has(id)


func get_tile(id:StringName) -> TacticalTileDefinition:
	return _map.get(id)
	
	
	
