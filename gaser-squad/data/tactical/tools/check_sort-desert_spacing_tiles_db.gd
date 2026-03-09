@tool
extends EditorScript

const PATH : = &"res://data/tactical/tile_db.tres"

func _run():
	var tile_db : TacticalTileDatabase = ResourceLoader.load(PATH, "", ResourceLoader.CacheMode.CACHE_MODE_REPLACE)

	_sort(tile_db)
	_check(tile_db)
	
	# save only first time
	#ResourceSaver.save(tile_db, PATH)

static func _sort(tile_db : TacticalTileDatabase):
	tile_db.tiles.sort_custom(func(a, b):
		return String(a.id) < String(b.id)
		)



static func _check(tile_db : TacticalTileDatabase):
	print("check --->")

	tile_db._rebuild()

	for t in tile_db.tiles :
		var parsed = _parse_tile_id(t.id)
		if parsed.is_empty():
			continue

		var material = parsed.material
		var shape = parsed.shape

		if material == "ground" and shape != "full":
			push_warning("ground tile '%s' should not have shape" % t.id)

		# если материал неизвестный — пропускаем (деревья, кусты и т.д.)
		if not MATERIAL_PROPERTIES.has(material):
			continue

		# проверка формы
		if not VALID_SHAPES.has(shape):
			push_warning("Unknown shape '%s' in tile '%s'" % [shape, t.id])
			continue

		# применяем свойства материала
		#_apply_material_properties(t, material)

		# генерируем destroyed_to
		#var next_id = _build_destroyed_id(material, shape)
		#if next_id != StringName():
		#	t.destroyed_to = next_id

		if t.destroyed_to and not tile_db.has_tile(t.destroyed_to):
			push_warning("tile '%s' can't destroy to '%s' - no in db" % [t.id, t.destroyed_to])

		t.print_validation_warnings()


	print("check - end!!!!")




const MATERIAL_DEGRADE := {
	"tile": "cobble",
	"cobble": "gravel",
	"gravel": "ground"
}

const VALID_SHAPES := {
	"full": true,
	"oulc": true,
	"ourc": true,
	"oblc": true,
	"obrc": true,
	"iulc": true,
	"iurc": true,
	"iblc": true,
	"ibrc": true,
	"ub": true,
	"bb": true,
	"lb": true,
	"rb": true
}

const MATERIAL_PROPERTIES := {

	"ground": {
		"display_name" : "твердый утоптаный грунт",
		"walkable": true,
		"move_cost": 1,
		"blocks_vision": false,
		"blocks_projectiles": false,
		"destructible": false
	},

	"gravel": {
		"display_name" : "мелкий гравий",
		"walkable": true,
		"move_cost": 2,
		"blocks_vision": false,
		"blocks_projectiles": false,
		"destructible": true,
		"damage_to_destroy": 10
	},

	"cobble": {
		"display_name" : "булыжники, остатки стены",
		"walkable": true,
		"move_cost": 4,
		"blocks_vision": false,
		"blocks_projectiles": false,
		"cover_type" : TacticalTileDefinition.CoverType.HALF_COVER,
		"destructible": true,
		"damage_to_destroy": 20
	},

	"tile": {
		"display_name" : "на вид крепкая стена",
		"walkable": false,
		"blocks_vision": true,
		"blocks_projectiles": true,
		"cover_type" : TacticalTileDefinition.CoverType.FULL_COVER,
		"destructible": true,
		"damage_to_destroy": 30,
		"allows_items": false
	}
}


static func _parse_tile_id(id:StringName) -> Dictionary:

	var s := String(id)
	var parts := s.split(" ")

	if parts.size() == 1:
		return {
			"material": parts[0],
			"shape": "full"
		}

	if parts.size() == 2:
		return {
			"material": parts[0],
			"shape": parts[1]
		}

	return {}


static func _build_destroyed_id(material:String, shape:String) -> StringName:

	if not MATERIAL_DEGRADE.has(material):
		return StringName()

	var next_material = MATERIAL_DEGRADE[material]

	if next_material == "ground":
		return StringName(next_material)

	return StringName("%s %s" % [next_material, shape])


static func _apply_material_properties(t:TacticalTileDefinition, material:String):

	if not MATERIAL_PROPERTIES.has(material):
		return

	var properties = MATERIAL_PROPERTIES[material]
	for key in properties:
		t.set(key, properties[key])
