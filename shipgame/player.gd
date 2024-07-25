extends Area2D

@export var max_speed = 500 # How fast the player will move (pixels/sec).
@export var fric = 0.3 # percentage "air resistance"
@export var accel = 1000
@export var control = 50 # constant decceleration when not accelerationg
var vel # current (x, y) velocity
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	vel = Vector2(0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# set player rotation to where the mouse is
	look_at(get_global_mouse_position())
	
	# slowdown due to friction
	vel -= vel * fric * delta
	
	# acceleration
	var accel_vector = Vector2(0, 0) # acceleration vector (forward, sideways)
	if Input.is_action_pressed("move_forward"):
		accel_vector.x = 1
	elif Input.is_action_pressed("move_backward"):
		accel_vector.x = -1
	if Input.is_action_pressed("move_right"):
		accel_vector.y = 1
	elif Input.is_action_pressed("move_left"):
		accel_vector.y = -1
	accel_vector = accel_vector.rotated(self.get_rotation())
	# if no acceleration, eventually stop the ship
	if accel_vector.is_zero_approx():
		vel -= vel.normalized() * 5 * delta # small constant decceleration
		if vel.length() < 1:
			vel = Vector2(0, 0)
	
	print(accel_vector)
	
	vel.x += accel_vector.x * accel * delta
	vel.y += accel_vector.y * accel * delta
	if vel.length() > max_speed:
		vel *= max_speed / vel.length()
	
	position += vel * delta
	
