# res://data/definitions/item_definition.gd
extends Resource
class_name ItemDefinition

@export var id: String
# ID of the item (идентификатор предмета)

@export var display_name: String
# Display name (отображаемое имя)

@export var icon: Texture2D
# Icon for UI (иконка для интерфейса)

@export var weight: float = 0.0
# Weight per unit (вес за одну единицу)

@export var stackable: bool = false
# Can be stacked in inventory (можно складывать в стопки)

@export var max_stack: int = 1
# Maximum stack size (максимальный размер стопки)
