class_name TacticalTileDefinition extends Resource 

## Surface type (тип поверхности)
enum SurfaceType {
	## liquid (жидкость)
	LIQUID,
	## solid (твердая)
	SOLID
}

## Cover type (тип укрытия)
enum CoverType {
	## 
	NONE,
	## 
	HALF_COVER,
	## 
	FULL_COVER
}


## 
@export var id : StringName
## 
@export var name : String
## 
@export var surface_type: SurfaceType = SurfaceType.SOLID

## 
@export var walkable : bool = true
## 
@export var move_cost: int = 1

## 
@export var blocks_vision: bool = false
## 
@export var opacity: int = 1

## 
@export var blocks_projectiles: bool = false
## 
@export var flammable: bool = false

## 
@export var cover_type: CoverType = CoverType.NONE

## 
@export var destructible: bool = false
## 
@export var destroyed_to: StringName  # id of TileDefinition


## 
@export var allows_items: bool = true
