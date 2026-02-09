class_name SubMenuManager
extends CanvasLayer


signal stack_empty

@export var dim_color := Color(0, 0, 0, 0.80)
@export var layer_index := 100

const PUSH_OFFSET := 100.0
const PUSH_TIME := 0.35
const POP_TIME := 0.25

var _stack: Array[Control] = []
var _animating := false

var blocker: Control
var stack_root: Control

# -------------------------------------------------

func _ready():
	layer = layer_index

	# ---------- Blocker ----------
	blocker = Control.new()
	blocker.name = "Blocker"
	blocker.anchor_left = 0
	blocker.anchor_top = 0
	blocker.anchor_right = 1
	blocker.anchor_bottom = 1
	blocker.mouse_filter = Control.MOUSE_FILTER_STOP
	blocker.visible = false
	add_child(blocker)

	blocker.draw.connect(_draw_blocker)

	# ---------- Stack root ----------
	stack_root = Control.new()
	stack_root.name = "StackRoot"
	stack_root.anchor_left = 0
	stack_root.anchor_top = 0
	stack_root.anchor_right = 1
	stack_root.anchor_bottom = 1
	blocker.add_child(stack_root)

# -------------------------------------------------

func _draw_blocker():
	blocker.draw_rect(
		Rect2(Vector2.ZERO, blocker.size),
		dim_color,
		true
	)


func _grab_focus_safely(target: Control) -> void:
	var focusable = _find_first_focusable(target)
	if focusable:
		focusable.grab_focus() #.call_deferred()
	else:
		# target.focus_mode = Control.FOCUS_ALL
		# target.grab_focus()
		push_warning("SubMenuManager: не найдено фокусируемых элементов в подменю '%s'" % target.name)

func _find_first_focusable(parent: Control) -> Control:
	# Поиск в ширину первого фокусируемого элемента
	var queue: Array[Node] = [parent]
	while not queue.is_empty():
		var node: Node = queue.pop_front()
		if node is Control and node.focus_mode != Control.FOCUS_NONE:
			return node
		for child in node.get_children():
			queue.push_back(child)
	return null




# -------------------------------------------------
# Public API
# -------------------------------------------------

func has_menu() -> bool:
	return not _stack.is_empty()

func current() -> Control:
	return _stack.is_empty() if null else _stack[-1] as Control 

func push(menu: Control):
	if _animating:
		return

	if menu.get_parent() != stack_root:
		push_error("Menu must be child of StackRoot")
		return

	_animating = true

	if _stack.is_empty():
		blocker.visible = true
		blocker.modulate.a = 0.0
		create_tween().tween_property(blocker, "modulate:a", 1.0, PUSH_TIME)

	if not _stack.is_empty():
		_stack[-1].visible = false

	_stack.append(menu)

	menu.visible = true
	menu.modulate.a = 0.0
	menu.position.y += PUSH_OFFSET

	blocker.mouse_filter = Control.MOUSE_FILTER_IGNORE

	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(menu, "modulate:a", 1.0, PUSH_TIME)
	tween.parallel().tween_property(menu, "position:y", menu.position.y - PUSH_OFFSET, PUSH_TIME)

	tween.finished.connect(func():
		blocker.mouse_filter = Control.MOUSE_FILTER_STOP
		#menu.grab_focus()
		
		_grab_focus_safely(menu)

		menu.grab_focus()
		_animating = false
	)

func pop():
	if _stack.is_empty() or _animating:
		return

	_animating = true

	var menu : Control = _stack.pop_back()
	blocker.mouse_filter = Control.MOUSE_FILTER_IGNORE

	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(menu, "modulate:a", 0.0, POP_TIME)
	tween.parallel().tween_property(menu, "position:y", menu.position.y + PUSH_OFFSET, POP_TIME)

	tween.finished.connect(func():
		menu.visible = false
		menu.position.y -= PUSH_OFFSET

		if _stack.is_empty():
			create_tween().tween_property(blocker, "modulate:a", 0.0, POP_TIME)
			await get_tree().process_frame
			blocker.visible = false
			emit_signal("stack_empty")
		else:
			var prev := _stack[-1]
			prev.visible = true
			#prev.grab_focus()
			_grab_focus_safely(prev)

		blocker.mouse_filter = Control.MOUSE_FILTER_STOP
		_animating = false
	)
