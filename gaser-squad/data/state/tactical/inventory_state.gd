class_name InventoryState
extends Object

var _items: Array = []   # ItemState[]
var _max_weight: float

func _init(max_weight: float):
	_max_weight = max_weight

## ============================================================
## BASIC
## ============================================================

func total_weight() -> float:
	var sum := 0.0
	for i in _items:
		sum += i.weight()
	return sum

func can_add(item: ItemState) -> bool:
	return total_weight() + item.weight() <= _max_weight

func add_item(item: ItemState) -> bool:
	if not can_add(item):
		return false

	if item.definition.stackable:
		for i in _items:
			if i.definition == item.definition and i.quantity < i.definition.max_stack:
				var space = i.definition.max_stack - i.quantity
				var to_add = min(space, item.quantity)
				i.quantity += to_add
				item.quantity -= to_add
				if item.quantity <= 0:
					return true

	_items.append(item)
	return true

func remove_item(item: ItemState):
	_items.erase(item)

func items() -> Array:
	return _items.duplicate()

## ============================================================
## QUERIES
## ============================================================

func find_ammo(ammo_type: String) -> ItemState:
	for i in _items:
		if i.definition is AmmoDefinition:
			if i.definition.ammo_type == ammo_type and i.quantity > 0:
				return i
	return null
