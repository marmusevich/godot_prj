@tool
class_name TacticalTileDefinition
extends Resource

##
## TacticalTileDefinition
##
## EN:
## Resource describing gameplay properties of a tactical tile.
## Used by movement, visibility, combat, and environment systems.
##
## Editing is allowed only in the Godot Editor.
## At runtime this resource behaves as read-only.
##
## RU:
## Ресурс, описывающий игровые свойства одной тактической клетки.
## Используется системами перемещения, видимости, боя и окружения.
##
## Редактирование разрешено только в редакторе Godo
## Во время выполнения (runtime) ресурс считается read-only.
##

# ===================================================================
# ENUMS
# ===================================================================

## Surface type (тип поверхности)
enum SurfaceType{
	## Liquid surface (water, lava, acid)
	## Жидкая поверхность (вода, лава, кислота)
	LIQUID,

	## Solid surface (ground, floor, road)
	## Твёрдая поверхность (земля, пол, дорога)
	SOLID
}

## Cover type (тип укрытия)
enum CoverType{
	## No cover.
	## Unit receives full damage and is fully visible.
	##
	## Нет укрытия.
	## Юнит получает полный урон и полностью видим.
	NONE,

	## Half cover.
	##
	## Standing unit receives reduced damage.
	## Crouched unit may become hidden.
	##
	## Полуукрытие.
	## Стоящий юнит получает уменьшенный урон.
	## Присевший юнит может быть скрыт.
	HALF_COVER,

	## Full cover.
	##
	## Object absorbs damage and blocks vision.
	##
	## Полное укрытие.
	## Препятствие принимает урон и блокирует обзор.
	FULL_COVER
}

# ===================================================================
# BASIC INFO
# ===================================================================

## Unique tile identifier.
## Must be unique inside TileDatabase.
##
## Уникальный идентификатор тайла.
## Должен быть уникальным в базе тайлов.
@export var id : StringName :
	set(value):
		if not Engine.is_editor_hint():
			push_error("TacticalTileDefinition [%s]: runtime modification 'id' forbidden" % id)
			return
		id = value
		#notify_property_list_changed()
		print_validation_warnings()

## Human readable tile name (UI/debug).
##
## Читаемое имя тайла (для UI и отладки).
@export var display_name : String :
	set(value):
		if not Engine.is_editor_hint():
			push_error("TacticalTileDefinition [%s]: runtime modification 'display_name' forbidden" % id)
			return
		display_name = value
		#notify_property_list_changed()
		print_validation_warnings()

## Surface type.
##
## Тип поверхности.
@export var surface_type : SurfaceType = SurfaceType.SOLID :
	set(value):
		if not Engine.is_editor_hint():
			push_error("TacticalTileDefinition [%s]: runtime modification 'surface_type' forbidden" % id)
			return
		surface_type = value
		#notify_property_list_changed()
		print_validation_warnings()

# ===================================================================
# MOVEMENT
# ===================================================================

## Whether units can stand on this tile.
##
## Можно ли юниту находиться на клетке.
@export var walkable : bool = true:
	set(value):
		if not Engine.is_editor_hint():
			push_error("TacticalTileDefinition [%s]: runtime modification 'walkable' forbidden" % id)
			return
		walkable = value
		#notify_property_list_changed()
		print_validation_warnings()

## Movement cost to enter this tile.
## Used by pathfinding algorithms.
##
## Стоимость перемещения по клетке.
## Используется алгоритмами поиска пути.
@export var move_cost : int = 1:
	set(value):
		if not Engine.is_editor_hint():
			push_error("TacticalTileDefinition [%s]: runtime modification 'move_cost' forbidden" % id)
			return
		move_cost = value
		#notify_property_list_changed()
		print_validation_warnings()

# ===================================================================
# VISION
# ===================================================================

## Whether this tile blocks line of sigh
##
## Блокирует ли клетка линию видимости.
@export var blocks_vision : bool = false:
	set(value):
		if not Engine.is_editor_hint():
			push_error("TacticalTileDefinition [%s]: runtime modification 'blocks_vision' forbidden" % id)
			return
		blocks_vision = value
		#notify_property_list_changed()
		print_validation_warnings()

## Opacity used by visibility algorithms.
##
## Higher values reduce visibility through the tile.
##
## Непрозрачность клетки для алгоритма видимости.
## Чем больше значение — тем сильнее затеняется линия взгляда.
@export var opacity : int = 0:
	set(value):
		if not Engine.is_editor_hint():
			push_error("TacticalTileDefinition [%s]: runtime modification 'opacity' forbidden" % id)
			return
		opacity = value
		#notify_property_list_changed()
		print_validation_warnings()

# ===================================================================
# COMBAT
# ===================================================================

## Blocks projectile travel (bullets, lasers).
##
## Блокирует полёт снарядов (пули, лазеры).
@export var blocks_projectiles : bool = false:
	set(value):
		if not Engine.is_editor_hint():
			push_error("TacticalTileDefinition [%s]: runtime modification 'blocks_projectiles' forbidden" % id)
			return
		blocks_projectiles = value
		#notify_property_list_changed()
		print_validation_warnings()

## Type of cover provided by this tile.
##
## Тип укрытия, предоставляемого клеткой.
@export var cover_type : CoverType = CoverType.NONE:
	set(value):
		if not Engine.is_editor_hint():
			push_error("TacticalTileDefinition [%s]: runtime modification 'cover_type' forbidden" % id)
			return
		cover_type = value
		#notify_property_list_changed()
		print_validation_warnings()

# ===================================================================
# DESTRUCTION
# ===================================================================

## Whether tile can be destroyed.
##
## Может ли клетка быть разрушена.
@export var destructible : bool = false:
	set(value):
		if not Engine.is_editor_hint():
			push_error("TacticalTileDefinition [%s]: runtime modification 'destructible' forbidden" % id)
			return
		destructible = value
		#notify_property_list_changed()
		print_validation_warnings()


## Tile ID that replaces this tile after destruction.
##
## ID тайла, в который превращается клетка после разрушения.
@export var destroyed_to : StringName:
	set(value):
		if not Engine.is_editor_hint():
			push_error("TacticalTileDefinition [%s]: runtime modification 'destroyed_to' forbidden" % id)
			return
		destroyed_to = value
		#notify_property_list_changed()
		print_validation_warnings()

## Damage required to destroy the tile.
##
## Урон, необходимый для разрушения клетки.
@export var damage_to_destroy : int = 0:
	set(value):
		if not Engine.is_editor_hint():
			push_error("TacticalTileDefinition [%s]: runtime modification 'damage_to_destroy' forbidden" % id)
			return
		damage_to_destroy = value
		#notify_property_list_changed()
		print_validation_warnings()

# ===================================================================
# ENVIRONMENT
# ===================================================================

## Whether tile can catch fire.
##
## Может ли клетка загореться.
@export var flammable : bool = false:
	set(value):
		if not Engine.is_editor_hint():
			push_error("TacticalTileDefinition [%s]: runtime modification 'flammable' forbidden" % id)
			return
		flammable = value
		#notify_property_list_changed()
		print_validation_warnings()

## Burning duration in turns.
##
## Длительность горения (в ходах).
@export var burning_time : int = 0:
	set(value):
		if not Engine.is_editor_hint():
			push_error("TacticalTileDefinition [%s]: runtime modification 'burning_time' forbidden" % id)
			return
		burning_time = value
		#notify_property_list_changed()
		print_validation_warnings()

# ===================================================================
# INTERACTION
# ===================================================================

## Whether items can be placed on the tile.
##
## Можно ли размещать предметы на клетке.
@export var allows_items : bool = true:
	set(value):
		if not Engine.is_editor_hint():
			push_error("TacticalTileDefinition [%s]: runtime modification 'allows_items' forbidden" % id)
			return
		allows_items = value
		#notify_property_list_changed()
		print_validation_warnings()

# ===================================================================
# VALIDATION CORE
# ===================================================================

##
## Returns list of validation messages.
##
## EN:
## Performs internal validation of the tile definition.
##
## RU:
## Выполняет проверку корректности описания тайла.
##
func get_validation_messages() -> PackedStringArray:
	var errors : PackedStringArray = []

	if id.is_empty():
		errors.append("Tile id is empty")

	if walkable and move_cost <= 0:
		errors.append("tile '%s' is walkable but move_cost=%d (should be >0)" % [id, move_cost])

	if destructible and not destroyed_to:
		errors.append("tile '%s' marked destructible but destroyed_to not set" % id)

	if destructible and damage_to_destroy <= 0:
		errors.append("tile '%s' marked destructible but damage_to_destroy <=0" % id)

	#if not blocks_vision and opacity <= 0:
	#	errors.append("tile '%s' does not block vision but opacity=%d" % [id, opacity])

	if blocks_projectiles and cover_type == CoverType.NONE:
		errors.append("tile '%s' blocks projectiles but cover_type is NONE" % id)

	if flammable and burning_time <= 0:
		errors.append("tile '%s' is flammable but burning_time <=0" % id)

	if flammable and not destructible:
		errors.append("tile '%s' is flammable but not destructible" % id)

	if allows_items and not walkable and not destructible:
		errors.append("tile '%s' allows items but is neither walkable nor destructible" % id)

	return errors


# ===================================================================
# VALIDATION HELPERS
# ===================================================================

##
## Print validation warnings to console.
##
## EN:
## Helper used by runtime or editor tools.
##
## RU:
## Вспомогательная функция для вывода предупреждений.
##
func print_validation_warnings() -> void:
	for m in get_validation_messages():
		push_warning(m)


# ===================================================================
# INSPECTOR WARNINGS
# ===================================================================

func _get_configuration_warnings() -> PackedStringArray:
	return get_validation_messages()


#func _validate_property_(property: Dictionary) -> void:
#	print_validation_warnings()
#	pass
