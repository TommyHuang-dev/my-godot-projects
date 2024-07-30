extends Area2D

@export var prop_cooldown = 0.25
var cooldown = 0

# the projectile shot by this weapon
var shot_scene = preload("res://basic_shot.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cooldown -= delta
	if cooldown <= 0 and Input.is_action_pressed("primary_fire"):
		cooldown = prop_cooldown
		
		var shot_instance = shot_scene.instantiate()
		shot_instance.speed = 1600
		shot_instance.lifetime = 1.2
		shot_instance.rotation = global_rotation
		shot_instance.position = global_position
		shot_instance.position += shot_instance.transform.x * 20
		get_tree().get_root().add_child(shot_instance)
