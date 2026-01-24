# res://data/state/modifier_state.gd
class_name ModifierState
extends Object

var definition: ModifierDefinition
var remaining_time: float = -1.0   # -1 = infinite (бесконечный)

func _init(def: ModifierDefinition, duration := -1.0):
	definition = def
	remaining_time = duration

func tick(delta: float):
	if remaining_time > 0:
		remaining_time -= delta
