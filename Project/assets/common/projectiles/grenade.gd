extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var lerp_to
var grenade_owner
export (PackedScene) var particles 
export var lerp_weight = .6
onready var gen_particles = $GrenadeParticles2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_particles(p):
	particles = p

func _process(delta):
	var p = Vector2(0,0)
	global_position = lerp(global_position,lerp_to,lerp_weight*delta)
	return move_and_slide(p)

func set_lerp_to(p):
	lerp_to = p
	print("Grenade pos: ",global_position," will Lerp to:",lerp_to)

func _on_Timer_timeout():
	var e = particles.instance()
	e.global_position = global_position
	get_parent().add_child(e)
	for i in $Area2D.get_overlapping_bodies():
		if i.is_in_group("enemy"):
			i.queue_free()
	queue_free()
	pass # Replace with function body.
