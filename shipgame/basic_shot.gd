extends Area2D

# TODO should make a projectile class
var velocity_vector = Vector2(100, 0)
var max_range = 1000
var lifetime = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if lifetime <= 0:
		queue_free()
	position += velocity_vector * delta
	lifetime -= delta


func _on_area_entered(area):
	print("projectile hit!")
	$CollisionShape2D.set_deferred("disabled", true)
	queue_free()
