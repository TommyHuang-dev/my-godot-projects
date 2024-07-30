extends Area2D

# TODO should make a projectile class
var speed = 100
var max_range = 1000
var lifetime = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if lifetime <= 0:
		queue_free()
	var vel_vec = transform.x * speed * delta
	position += vel_vec
	lifetime -= delta
