extends KinematicBody2D

signal use_grenade(new_value)
signal update_health(new_value)

export var SPEED = 8000
export var SPEED_MULTIPLIER = 10.0
export var DEADZONE_X = 128
export var DEADZONE_Y = 128
export var WEAPON_OFFSET_X = 32
export (PackedScene) var bullet
export (PackedScene) var grenade
export (PackedScene) var particles
#Timers
var DASH_COOLDOWN_TIME = 5
var SHOOT_TIMER_COOLDOWN = 0.3

#Controls / abilities
export (bool) var CAN_DASH = true
var invincible = false
var speed_lerp = .25
var mouse_pos = Vector2() 
var flipped = false
var moving_north = false
var velocity = 1.0
onready var  pistol = $AnimatedSprite/Weapons/Pistol
# Called when the node enters the scene tree for the first time.

var can_shoot = true
var grenades = 2
func _ready():
	Gobal.set_crosshair()
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
	b.bullet_owner ="player"
	b.global_position = $AnimatedSprite/Weapons/Pistol.global_position
	b.look_at(get_global_mouse_position())
	b.apply_impulse(Vector2(),Vector2(500,50).rotated(pistol.global_rotation))
	owner.add_child(b)
	can_shoot = false
	$Timers/ShootTimer.start(SHOOT_TIMER_COOLDOWN)

func throw():
	if grenades > 0:
		emit_signal("use_grenade")
		var g = grenade.instance()
		if g == null:
			return
		g.grenade_owner = "player"
		g.set_particles(particles)
		g.global_position = global_position
		g.set_lerp_to(get_global_mouse_position())
		owner.add_child(g)
		grenades-=1
		
	
	
	pass
func _handle_input(delta):
	$AnimatedSprite/Weapons.look_at(get_global_mouse_position())
	var pos = Vector2()
	#mouse_pos = get_viewport().get_mouse_position()
	mouse_pos = get_global_mouse_position()
	if mouse_pos.x > global_position.x + DEADZONE_X:
		pos.x += SPEED * velocity * delta
		flip_h(false)
	elif mouse_pos.x < global_position.x - DEADZONE_X:
		flip_h(true)
		pos.x -= SPEED * velocity * delta
	if mouse_pos.y > global_position.y + DEADZONE_Y:
		pos.y += SPEED * velocity *delta
		moving_north = false
	elif mouse_pos.y < global_position.y - DEADZONE_Y:
		pos.y -= SPEED * velocity * delta
		moving_north = true
	if Input.is_action_pressed("shoot") and can_shoot==true:
		shoot()
	if Input.is_action_just_pressed("grenade"):
		throw()
	
	#KEYS
	if CAN_DASH==true:
		if Input.is_action_pressed("ui_accept"):
			velocity = lerp(velocity,SPEED_MULTIPLIER,speed_lerp)
			print("Current Velocity: ",velocity, " Max: ", SPEED_MULTIPLIER)
			if velocity >= SPEED_MULTIPLIER:
					print("time to cool off")
					CAN_DASH = false
					$Timers/DashTimer.start(DASH_COOLDOWN_TIME)
	if CAN_DASH==false:
		velocity = lerp(velocity,1,speed_lerp)
		print(velocity)
	return move_and_slide(pos)
	
func _handle_collision(delta):
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		#print("Collided with: ", collision.collider.name)

func _handle_updates(delta):
	if Gobal.life <= 0:
		queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_handle_input(delta)
	_handle_collision(delta)
	_handle_updates(delta)


func _on_DashTimer_timeout():
	CAN_DASH = true
	pass # Replace with function body.


func _on_ShootTimer_timeout():
	can_shoot = true
	pass # Replace with function body.


func _on_LaserPod_player_hit():
	if invincible == false:
		Gobal.update_life(-1)
		invincible = true
		$Timers/InvincibilityTimer.start(2)
	pass # Replace with function body.


func _on_InvincibilityTimer_timeout():
	invincible = false
	pass # Replace with function body.
