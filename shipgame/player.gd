extends Area2D

@export var mass = 1000 # "average" ship will have mass = 1000
@export var thrust = 800 # "average" ship will have thrust = 800
@export var boost = 2400 # max boost

var drag = 0.5 # percentage "air resistance"
var fric = 10 + mass * 0.01 # constant decceleration

var max_speed = max(600 + (thrust - mass) * 0.1, 300) # How fast the player will move (pixels/sec).
var accel = thrust * 1000 / mass # nominal acceleration (pixels/sec^2)
var size_control_penalty = max(pow(100 + mass * 0.005, 0.5) - 9, 1)
var control = (2 * PI) * thrust / (mass * size_control_penalty) # max rotation speed (radians/sec)

var vel # current (x, y) velocity
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	vel = Vector2(0, 0)
	print("BASE STATS")
	print("mass: ", mass)
	print("thrust: ", thrust)
	print("\nDERIVED STATS")
	print("drag: ", drag)
	print("friction: ", fric)
	print("max_speed: ", max_speed)
	print("accel: ", accel)
	print("control penalty:", size_control_penalty)
	print("control: ", control)

# slides a towards b by between n and 2n, smoothed
func slide(a, b, peak, n):
	var diff = abs(a - b)
	var max_change = n * (0.5 + min(diff, 0.5))
	if diff < max_change: return b
	if a > b: return a - max_change
	if a < b: return a + max_change

# Called every frame. 'delta' is the elapsed time since the previous frame.
func turn(delta):
	#### rotation
	# turn player towards mouse
	var s = Vector2.from_angle(rotation)
	var m = get_global_mouse_position() - position
	var angle_to_mouse = s.angle_to(m)
	rotation += slide(0, angle_to_mouse, PI / 2, control * delta)

func accelerate(delta):
	#### movement
	vel -= vel * drag * delta # percentage slowdown
	vel -= vel.normalized() * fric * delta # small constant decceleration
	if vel.length() < fric * delta * 1.5:
		vel = Vector2(0, 0)
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
	
	var effective_accel = accel
	if Input.is_action_pressed("boost"):
		effective_accel += boost
	vel.x += accel_vector.x * effective_accel * delta
	vel.y += accel_vector.y * effective_accel * delta
	if vel.length() > max_speed:
		vel *= max_speed / vel.length()
	
	position += vel * delta

func _process(delta):
	turn(delta)
	accelerate(delta)
