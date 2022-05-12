extends KinematicBody2D

signal player_hit


export var SPEED = 2000
export var AI_LEVEL = 1
export (PackedScene) var laser

var trackingPlayer = false
var playerRef

func _ready():
	pass # Replace with function body.



func _process(delta):
	_handle_input(delta)
	_handle_collision(delta)
	pass

func _handle_input(d):
	var move = Vector2.ZERO
	if trackingPlayer == true and is_instance_valid(playerRef):
		$LaserPoint.global_position= lerp($LaserPoint.global_position,playerRef.position,SPEED*d)
	move = move.normalized()
	move = move_and_slide(move)
	pass

func _handle_collision(delta):
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.is_in_group("bullet"):
			collision.collider.queue_free()
			queue_free()
	pass


func shoot():
	print("Shot ", get_groups(), " laser.")
	if trackingPlayer == true and is_instance_valid(playerRef):
		var l = laser.instance()
		l.laser_owner ="enemy"
		l.add_point(global_position)
		l.add_point(playerRef.global_position)
		#l.look_at(playerRef.global_position)
		#b.apply_impulse(Vector2(),Vector2(500,50).rotated(b.global_rotation))
		owner.add_child(l)
	pass


#SIGNALS
func _on_player_entered(body):
	if body.is_in_group("player") == true:
		playerRef = body
		print("Tracking player at: ",playerRef.position)
		trackingPlayer = true
	if $Timers/AITimer.is_stopped():
		$Timers/AITimer.start(2)
	pass # Replace with function body.


func _on_AITimer_timeout():
	shoot()
	pass # Replace with function body.


func _on_player_exited(body):
	if body.is_in_group("player") == true:
		trackingPlayer = false
		playerRef = null
	pass # Replace with function body.
