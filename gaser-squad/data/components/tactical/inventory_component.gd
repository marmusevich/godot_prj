extends Object
class_name InventoryComponent

var inventory: InventoryState

func _init(max_weight: float):
	inventory = InventoryState.new(max_weight)

func add_item(item: ItemState) -> bool:
	return inventory.add_item(item)

func remove_item(item: ItemState):
	inventory.remove_item(item)

func find_ammo(ammo_type: String) -> ItemState:
	return inventory.find_ammo(ammo_type)

func total_weight() -> float:
	return inventory.total_weight()

func items() -> Array:
	return inventory.items()
