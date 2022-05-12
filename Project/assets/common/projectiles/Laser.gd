extends Line2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var laser_owner
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	$Area2D.position = get_point_position(1)


func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	if body.is_in_group("player") == true:
		print("player hit")
		body._on_LaserPod_player_hit()
	pass # Replace with function body.
