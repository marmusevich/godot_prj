extends Node2D


var planet_size: float = 0.0
var color : Color = Color.WHITE


func _draw():
	
	draw_circle(Vector2.ZERO, planet_size, color)
	
	
	var default_font = ThemeDB.fallback_font
	var default_font_size = ThemeDB.fallback_font_size
	var str = "-----------"
	draw_string(default_font, Vector2.ZERO, str, HORIZONTAL_ALIGNMENT_CENTER, -1, default_font_size)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#rotata animation 
	rotation += delta
	pass	
