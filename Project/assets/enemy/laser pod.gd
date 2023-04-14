extends KinematicBody2D

signal player_hit


export var SPEED = 2000
export var SHOOTING_TIME = 2
export var AI_LEVEL = 1
export (PackedScene) var laser

var laserTracker 
var trackingPlayer = false
var shooting = false
var playerRef

func _ready():
	laserTracker = global_position
	pass # Replace with function body.



func _process(delta):
	_handle_input(delta)
	shoot(delta)
	_handle_collision(delta)
	pass

func _handle_input(d):
	var move = Vector2.ZERO
	if trackingPlayer == true and is_instance_valid(playerRef):
		$LaserPoint.global_position= global_position.direction_to(playerRef.global_position) * SPEED * d
		
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


func shoot(delta):
	#print("Shot ", get_groups(), " laser.")
	if trackingPlayer == true and is_instance_valid(playerRef) and shooting == true:
		var l = laser.instance()
		l.laser_owner ="enemy"
		l.add_point(global_position)
		laserTracker =lerp(laserTracker,playerRef.global_position,1*delta)
		l.add_point(laserTracker)
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
	shooting = true
	$Timers/ShootTimer.start(SHOOTING_TIME*AI_LEVEL)
	pass # Replace with function body.


func _on_player_exited(body):
	if body.is_in_group("player") == true:
		trackingPlayer = false
		playerRef = null
	pass # Replace with function body.


func _on_ShootTimer_timeout():
	shooting = false
	pass # Replace with function body.
