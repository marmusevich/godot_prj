class_name PrimaryButton extends Button

signal activated(id: StringName)

@export var button_id : StringName = "default"

@export var ease_type : Tween.EaseType
@export var transition_type : Tween.TransitionType
@export var anim_durftion : float = 0.1
@export var scale_amount : Vector2 = Vector2(1.1, 1.1)
@export var click_sound: AudioStream
@export var default_size := Vector2i(300, 70) 



var _tween : Tween
var _audio_player: AudioStreamPlayer


func _ready() -> void:
	self.custom_minimum_size = default_size
	self.pivot_offset_ratio = Vector2(0.2, 0.5)
	
	self.mouse_entered.connect(_on_hover.bind(true))
	self.mouse_exited.connect(_on_hover.bind(false))
	self.focus_entered.connect(_on_hover.bind(true))
	self.focus_exited.connect(_on_hover.bind(false))

	self.button_down.connect(_on_button_down)
	self.button_up.connect(_on_button_up)
	
	self.pressed.connect(_on_pressed)
		
	_audio_player = AudioStreamPlayer.new()
	add_child(_audio_player)

	
	
	
func _on_hover(hovered : bool) -> void:
	_reset_tweem()
	_tween.tween_property(self, "scale", scale_amount if hovered else Vector2.ONE, anim_durftion)
	

func _reset_tweem() -> void :
	if (_tween):
		_tween.kill()
		
	_tween = create_tween().set_ease(ease_type).set_trans(transition_type).set_parallel(true)
	

func _on_button_up() -> void:
	if click_sound:
		_audio_player.stream = click_sound
		_audio_player.play()

	#_reset_tweem()
	#_tween.tween_property(self, "scale", scale_amount*2, anim_durftion)
		


func _on_button_down() -> void:
	pass
	#_reset_tweem()
	#_tween.tween_property(self, "scale", Vector2.ONE, anim_durftion)



func _on_pressed() -> void:
	activated.emit(button_id)
	
