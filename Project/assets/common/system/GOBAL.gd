extends Node

signal life_changed

var crosshair = load("res://assets/common/system/mouse/crosshair.png")
var maxLife = 3
var life = maxLife
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_custom_mouse_cursor(crosshair)
	pass # Replace with function body.

func set_crosshair():
	Input.set_custom_mouse_cursor(crosshair)
	
func update_life(var d):
	life+=d
	emit_signal("life_changed")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
