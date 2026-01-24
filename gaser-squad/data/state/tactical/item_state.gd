# res://data/state/item_state.gd
class_name ItemState
extends Object

var definition: ItemDefinition
var quantity: int = 1

func _init(def: ItemDefinition, qty := 1):
	assert(def != null)
	definition = def
	quantity = qty

func weight() -> float:
	return definition.weight * quantity
