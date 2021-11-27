extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _handle_collision(delta):
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.is_in_group("bullet"):
			queue_free()
	pass

func _process(delta):
	_handle_collision(delta)
	pass
