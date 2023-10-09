extends Node2D

@onready var camera := $Camera2D as Camera2D
@onready var star_scene: PackedScene = preload("res://star_system/star.tscn")
@onready var planetaryObject_scene: PackedScene = preload("res://star_system/PlanetaryObject.tscn")

var systemInfo : StarSystemInfo = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("--------------------------------------------")
	systemInfo = StarSystemWorker.generate_info(null)
	#print(inst_to_dict(sys))
	#var star := systemInfo.star
	add_child(star_scene.instantiate())
	for o in systemInfo.objects :
		var pl = o as StarSystemInfo.PlanetInfo
		if pl == null : continue
		
		print("planet name ", pl.name)
		var planet := planetaryObject_scene.instantiate()
		planet.info_data = pl
		add_child(planet)


	print("--------------------------------------------")


# Called every frame. 'delta' is the elapsed time since the previous frame.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#scroll screen - begin
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var mouse_pos = get_viewport().get_mouse_position()
		var v_size = get_viewport_rect().size
		var d := Vector2.ZERO
		const PIXEL_1 : int = 50
		const PIXEL_2 : int = 10
		if(mouse_pos.x < PIXEL_1):
			d.x = -PIXEL_2
		elif (mouse_pos.x > v_size.x - PIXEL_1):
			d.x = +PIXEL_2

		if(mouse_pos.y < PIXEL_1):
			d.y = -PIXEL_2
		elif (mouse_pos.y > v_size.y - PIXEL_1):
			d.y = +PIXEL_2
	
		camera.position += d 
	#scroll screen - end

	pass
		
		
func _input(event: InputEvent):
	
	if event.is_action_pressed(&"zoom_in"):
		camera.zoom *= 1.5
		print("zoom_in  = ", camera.zoom)
	elif event.is_action_pressed(&"zoom_out"):
		camera.zoom /= 1.5
		print("zoom_out = ", camera.zoom)
	elif event.is_action_pressed(&"move_left"):
		camera.position.x -= 10
		print("position = ", camera.position)
	elif event.is_action_pressed(&"move_right"):
		camera.position.x += 10
		print("position = ", camera.position)
	elif event.is_action_pressed(&"move_up"):
		camera.position.y -= 10
		print("position = ", camera.position)
	elif event.is_action_pressed(&"move_down"):
		camera.position.y += 10
		print("position = ", camera.position)
