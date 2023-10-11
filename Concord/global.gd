extends Node


@export var tic : float = 0
@export var isTicEnabled : bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isTicEnabled :
		#print("tic = ", tic, "  time", Time.get_ticks_msec())
		tic += delta #Time.get_ticks_msec()
	pass
