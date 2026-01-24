extends Object
class_name BaseState

var _definition: BaseDefinition # Reference to definition (ссылка на определение)

func _init(def: BaseDefinition):
	assert(def != null)
	_definition = def

func get_display_name() -> String:
	return _definition.display_name
