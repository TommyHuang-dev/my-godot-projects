extends Sprite2D
signal hit

@export var speed: = 300.0
var direction = [1,0]  # x, y direction

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("move_right"):
		direction[0] = 1
		direction[1] = 0
		rotation_degrees = 0
	if Input.is_action_pressed("move_left"):
		direction[0] = -1
		direction[1] = 0
		rotation_degrees = 180
	if Input.is_action_pressed("move_down"):
		direction[0] = 0
		direction[1] = 1
		rotation_degrees = 90
	if Input.is_action_pressed("move_up"):
		direction[0] = 0
		direction[1] = -1
		rotation_degrees = 270
	
	position.x += direction[0] * speed * delta
	position.y += direction[1] * speed * delta
	if position.y < -30:
		position.y = get_viewport().size.y
	elif position.y > get_viewport().size.y + 30:
		position.y = -30
	if position.x < -30:
		position.x = get_viewport().size.x
	elif position.x > get_viewport().size.x + 30:
		position.x = -30
		
	
