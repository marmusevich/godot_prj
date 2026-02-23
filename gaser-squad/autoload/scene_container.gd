extends Node


func _ready() -> void:
	SceneManager.register_root(self)
	
	SceneManager.change_scene(SceneManager.MAIN_MENU)
	#SceneManager.change_scene(SceneManager.start_gama_scene)
