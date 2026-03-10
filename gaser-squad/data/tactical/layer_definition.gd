@tool
class_name TacticalLayerDefinition extends Resource

enum LayerType
{
	TERRAIN,
}

##
@export var layer_type: LayerType = LayerType.TERRAIN
@export var name: StringName

@export var tile_set : TileSet

# Массив тайлов
@export var tile_ids: Array[InLayerTileReferenceDefinition]
