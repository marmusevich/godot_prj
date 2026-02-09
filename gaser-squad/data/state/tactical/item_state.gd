class_name ItemState extends BaseState

var quantity: int = 1

func _init(def: ItemDefinition, qty := 1):
	super(def)
	quantity = qty

func weight() -> float:
	return _definition.weight * quantity
