extends Label
class_name AnimatedCount

@export var value : int = 0 : set = _on_value_set

#intermediate
var int_val : int = 0 : set = _on_int_val_set
var tween : Tween


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		value = randi_range(0, 1000)
		print("New rand val = ", value)


func _on_value_set(new_val : int) -> void:
	value = new_val
	
	if tween:
		tween.kill()
	
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "int_val", value, 2.0)


func _on_int_val_set(new_val : int) -> void:
	int_val = new_val;
	text = str(int_val)
