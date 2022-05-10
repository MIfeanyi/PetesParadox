extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var lerp_to
var grenade_owner
export (PackedScene) var particles
export var lerp_weight = .6
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	var p = Vector2(0,0)
	global_position = lerp(global_position,lerp_to,lerp_weight*delta)
	return move_and_slide(p)

func set_lerp_to(p):
	lerp_to = p
	print("Grenade pos: ",global_position," will Lerp to:",lerp_to)

func _on_Timer_timeout():
	#generate_explosion
	#dmg zone
	queue_free()
	pass # Replace with function body.
