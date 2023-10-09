extends Node2D


var planet_size: float = 0.0
var color : Color = Color.WHITE


#func _draw():
#	draw_circle(Vector2.ZERO, planet_size, color)
#	
#	var default_font = ThemeDB.fallback_font
#	var default_font_size = ThemeDB.fallback_font_size
#	var str = "-----------"
#	draw_string(default_font, Vector2.ZERO, str, HORIZONTAL_ALIGNMENT_CENTER, -1, default_font_size)


func calcSize(_size : StarSystemInfo.PlanetSize) -> float :
	var ret: float = 0.0
	match _size:
		StarSystemInfo.PlanetSize.TINY :
			ret = 0.6
		StarSystemInfo.PlanetSize.SMALL :
			ret = 0.9
		StarSystemInfo.PlanetSize.NORMAL :
			ret = 1 
		StarSystemInfo.PlanetSize.BIG :
			ret = 2
		StarSystemInfo.PlanetSize.LARGE :
			ret = 4
			
	return ret


func _ready() -> void:
	var info_data = get_parent().info_data
	if info_data != null :
		var sc = 0.2 * calcSize(info_data.size)
		scale = Vector2(sc, sc)
		$Sphere.texture = load("res://star_system/art/kenney_planets/light%02d.png" % randi_range(0, 10))
		$Noise.texture = load("res://star_system/art/kenney_planets/noise%02d.png" % randi_range(0, 27))
		$Light.texture = load("res://star_system/art/kenney_planets/sphere%d.png" % randi_range(0, 2))
		#var random_color = Color(randf(), randf(), randf())
		
		$Sphere.modulate = Color(randf(), randf(), randf())
		$Noise.modulate = Color(randf(), randf(), randf())


func _process(delta: float) -> void:
	#rotata animation 
	#rotation += delta
	$Light.rotation += delta*4
	#pass	
