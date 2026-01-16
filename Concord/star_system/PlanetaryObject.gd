extends Node2D

var info_data : StarSystemInfo.PlanetaryInfo = null

@onready var moon_scene: PackedScene = preload("res://star_system/PlanetaryObject.tscn")

var speed : float = 0
var radius : float = 0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if info_data == null : return
	
	speed = info_data.speed #/ 10
	radius = info_data.radius * 1100 + 100
		
	var obj_name = info_data.name
	print("name  >", obj_name, "<  speed ", speed, " radius ", radius)
	
	
	#var info = get_parent().info
	#var planet_size = info.size * 50 + 50
	# todo switch size and collor
	#var size : = PlanetSize.NORMAL
	
	#$visual.planet_size = 50 + 25 * info_data.size
	#$visual.color = Color.AQUA if info_data is StarSystemInfo.PlanetInfo else Color.GRAY
	
	
	#add moons
	var pl = info_data as StarSystemInfo.PlanetInfo
	if pl == null or pl.objects.size() == 0: return
	for o in  pl.objects :
		var m = o as StarSystemInfo.MoonInfo
		if m == null : continue
		print("moon name ", m.name)
		var moon = moon_scene.instantiate()
		moon.info_data = m
		add_child(moon)

	
	
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if info_data == null : return

	var t = Global.tic #Time.get_ticks_msec()
	var angl = (deg_to_rad(t) * speed + info_data.start_angle) * (+1 if info_data.direction == StarSystemInfo.OrbitDirection.DIRECT else -1)
	position = Vector2(radius * sin(angl), radius * cos(angl))

