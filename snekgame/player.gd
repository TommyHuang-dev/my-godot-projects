extends Area2D
signal hit
signal move

@export var speed = 3.0 # squares/sec
@export var speed_inc = 0.2 # increase in speed per food
@export var starting_length = 4 # length including the head
var screen_size
var grid_size
var move_wait = 1  # when this gets down to 0, move


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	grid_size = 60 # TODO should be a constant somewhere


var direction = Vector2(1,0) # Movement vector
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("move_right"):
		direction.x = 1
		direction.y = 0
	elif Input.is_action_just_pressed("move_down"):
		direction.x = 0
		direction.y = 1
	elif Input.is_action_just_pressed("move_left"):
		direction.x = -1
		direction.y = 0
	elif Input.is_action_just_pressed("move_up"):
		direction.x = 0
		direction.y = -1
	
	move_wait -= delta * speed
	if move_wait <= 0:
		move.emit()
		
		move_wait += 1
		if direction == Vector2(1,0):
			rotation = 0
		elif direction == Vector2(0,1):
			rotation = PI / 2
		elif direction == Vector2(-1,0):
			rotation = PI
		elif direction == Vector2(0,-1):
			rotation = PI * 3/2
		position += direction * grid_size
		
		if position.x > screen_size.x:
			position.x = grid_size / 2
		elif position.y > screen_size.y:
			position.y = grid_size / 2
		elif position.x < 0:
			position.x = screen_size.x - grid_size / 2
		elif position.y < 0:
			position.y = screen_size.y - grid_size / 2


func _on_body_entered(body):
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
