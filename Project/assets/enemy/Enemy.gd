extends KinematicBody2D

export var SPEED = 2000
export var AI_LEVEL = 1

var trackingPlayer = false
var playerRef
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _handle_collision(delta):
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		print(collision)
		if collision.collider.is_in_group("bullet"):
			#collision.collider.queue_free()
			queue_free()
	pass
	
func _handle_input(d):
	var move = Vector2.ZERO
	if trackingPlayer == true:
		move = position.direction_to(playerRef.position) * SPEED * d
	move = move.normalized()
	move = move_and_collide(move)
	pass

func _process(delta):
	_handle_input(delta)
	_handle_collision(delta)
	pass


func _on_player_entered(body):
	if body.is_in_group("player") == true:
		playerRef = body
		print("Tracking player at: ",playerRef.position)
		trackingPlayer = true
	pass # Replace with function body.
