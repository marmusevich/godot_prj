extends Node2D

var info : StarSystemInfo.PlanetaryInfo = null

var speed : float = 0
var radius : float = 0

@onready var moon_scene: PackedScene = preload("res://star_system/PlanetaryObject.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if info == null : return
	speed = info.speed / 500
	radius = info.radius * 800 + 100
		
	var name = info.name
	print("name  >", name, "<  speed ", speed, " radius ", radius)
	
	
	#var info = get_parent().info
	#var planet_size = info.size * 50 + 50
	# todo switch size and collor
	#var size : = PlanetSize.NORMAL
	$visual.planet_size = 50 + 25 * info.size
	$visual.color = Color.AQUA if info is StarSystemInfo.PlanetInfo else Color.GRAY
	
	
	#add moons
	var pl = info as StarSystemInfo.PlanetInfo
	if pl == null or pl.objects.size() == 0: return
	for o in  pl.objects :
		var m = o as StarSystemInfo.MoonInfo
		if m == null : continue
		print("moon name ", m.name)
		var moon = moon_scene.instantiate()
		moon.info = m
		add_child(moon)

	
	
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if info == null : return
	var t = Time.get_ticks_msec()
	var angl = (deg_to_rad(t) * speed + info.start_angle) * (+1 if info.direction == StarSystemInfo.OrbitDirection.DIRECT else -1)
	position = Vector2(radius * sin(angl), radius * cos(angl))
