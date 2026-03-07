class_name TacticalMapDefinition extends Resource

@export var size : Vector2i

@export var tile_db:TacticalTileDatabase

## for siplefy only 1 layer
#@export var layers: Array[TacticalLayerDefinition]
@export var layer: TacticalLayerDefinition


const SPAWN_LAYER_NAME: StringName = &"_SpawnPlaces"

## Using for randomly placed items or units. Or may used to player palces its units.
## Используется для случайного размещения предметов или юнитов. Или может использоваться для размещения игроком своих юнитов.
@export var posible_spawn_pos_team_1 : Array[Vector2i]
@export var posible_spawn_pos_team_2 : Array[Vector2i]
@export var posible_spawn_pos_item : Array[Vector2i]
