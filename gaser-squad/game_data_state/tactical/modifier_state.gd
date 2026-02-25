class_name ModifierState extends Object

var definition: ModifierDefinition
var remaining_time: float = -1.0   # -1 = infinite (бесконечный)

func _init(def: ModifierDefinition, duration := -1.0):
	definition = def
	remaining_time = duration

func tick(delta: float):
	if remaining_time > 0:
		remaining_time -= delta

func is_expired() -> bool:
	return remaining_time == 0 or remaining_time < 0 and remaining_time != -1
