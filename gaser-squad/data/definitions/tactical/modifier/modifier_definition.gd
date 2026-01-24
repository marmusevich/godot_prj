# res://data/definitions/modifier_definition.gd
extends Resource
class_name ModifierDefinition


@export var id: String
@export var display_name: String
@export var description: String   # UI text (описание)
@export var is_buff: bool = true   # Buff or debuff (баф / дебаф)
