extends Node

### parent node for all game modes

func _ready() -> void:
	SceneManager.register_root(self)
	
	#SceneManager.change_scene(SceneManager.MAIN_MENU)
	# for debug
	SceneManager.change_scene(SceneManager.TACTICAL_MAIN)
