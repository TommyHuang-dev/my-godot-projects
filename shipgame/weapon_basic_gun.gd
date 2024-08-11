extends Area2D

# properties of the gun
@export var prop_cooldown = 0.1
var cooldown
# the projectile shot by this weapon
var shot_class = preload("res://basic_shot.tscn")
@export var shot_speed = 1600

# Called when the node enters the scene tree for the first time.
func _ready():
	cooldown = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cooldown -= delta
	# on cooldown or not shooting
	if cooldown > 0 or not Input.is_action_pressed("primary_fire"):
		return
	
	cooldown = prop_cooldown
	var shot_instance = shot_class.instantiate()
	# set base projectile stats and setup location
	shot_instance.position = global_position
	shot_instance.position += shot_instance.transform.x * 20
	shot_instance.lifetime = 1.0
	shot_instance.rotation = global_rotation
	var base_velocity_vector = Vector2(shot_speed, 0).rotated(global_rotation)
	
	# add player velocity
	var player_group = get_tree().get_nodes_in_group("PlayerGroup")
	var player_velocity_vector = Vector2(0, 0)
	if len(player_group) > 0:
		var p = player_group[0]  # the player should always be the first one in this group
		# velocity of the player is the current base velocity,
		#  plus possibly extra speed from dodging (boosting)
		player_velocity_vector = p.vel + p.curr_dodge_vec * p.dodge_decay_factor
	
	# calculate final velcoity, convert to speed and direction
	var final_velocity_vector = base_velocity_vector + player_velocity_vector
	shot_instance.velocity_vector = final_velocity_vector
	
	# be free my projectile!
	get_tree().get_root().add_child(shot_instance)
