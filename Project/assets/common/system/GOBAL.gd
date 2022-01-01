extends Node

var crosshair = load("res://assets/common/system/mouse/crosshair.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_custom_mouse_cursor(crosshair)
	pass # Replace with function body.

func set_crosshair():
	Input.set_custom_mouse_cursor(crosshair)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
