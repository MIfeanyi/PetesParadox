extends RigidBody2D

var speed = 100
var flipped = false
var moving_north = false
var slope_y
var slope_x
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.playing=true
	pass # Replace with function body.

func shoot(flip,north):
	flipped = flip
	moving_north = north
	
	slope_x = get_global_mouse_position().x - global_position.x
	slope_y = get_global_mouse_position().y - global_position.y
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
	#var move = Vector2()
	
	#move.x += slope_x * speed * delta
	#move.y += slope_y * speed * delta
	#move.normalized()
	
	#position = move

func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.
