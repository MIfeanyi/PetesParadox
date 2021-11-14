extends KinematicBody2D

export var SPEED = 2000
export var DEADZONE_X = 128
export var DEADZONE_Y = 128
export var WEAPON_OFFSET_X = 32
export (PackedScene) var bullet

var mouse_pos = Vector2() 
var flipped = false
var moving_north = false

onready var  pistol = $AnimatedSprite/Weapons/Pistol
# Called when the node enters the scene tree for the first time.
func _ready():
	if bullet == null:
		print("failed to instance bullet")
	pass # Replace with function body.

func flip_h(flip):
	if flip == true:
		$AnimatedSprite.flip_h = true
		$AnimatedSprite/Weapons/Pistol.flip_v = true
		flipped = true
		#$AnimatedSprite/Weapons/pistol.set_offset(Vector2(-WEAPON_OFFSET_X,0))
	else:
		$AnimatedSprite.flip_h = false
		$AnimatedSprite/Weapons/Pistol.flip_v = false
		flipped = false
		#$AnimatedSprite/Weapons/pistol.set_offset(Vector2(WEAPON_OFFSET_X,0))

func shoot():
	var b = bullet.instance()
	if b == null:
		print("bullet instance error")
		return
	b.look_at(get_global_mouse_position())
	b.global_position = $AnimatedSprite/Weapons/Pistol.global_position
	b.apply_impulse(Vector2(),Vector2(500,50).rotated(pistol.global_rotation))
	owner.add_child(b)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AnimatedSprite/Weapons.look_at(get_global_mouse_position())
	var pos = Vector2()
	mouse_pos = get_viewport().get_mouse_position()
	if mouse_pos.x > global_position.x + DEADZONE_X:
		pos.x += SPEED * delta
		flip_h(false)
	elif mouse_pos.x < global_position.x - DEADZONE_X:
		flip_h(true)
		pos.x -= SPEED * delta
	if mouse_pos.y > global_position.y + DEADZONE_Y:
		pos.y += SPEED * delta
		moving_north = false
	elif mouse_pos.y < global_position.y - DEADZONE_Y:
		pos.y -= SPEED * delta
		moving_north = true
	if Input.is_action_pressed("shoot"):
		shoot()
	return move_and_slide(pos)
