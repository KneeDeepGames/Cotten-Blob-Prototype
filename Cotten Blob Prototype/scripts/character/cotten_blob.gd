extends CharacterBody3D

# ---------- VARIABLES ---------- #

@export_category("Player Properties")
@export var move_speed : float = 6
@export var jump_force : float = 5
@export var follow_lerp_factor : float = 4
@export var jump_limit : int = 2
@export var cam_pos_offset:Vector3
@export var push_force:int = 8

@export_group("Game Juice")
@export var jumpStretchSize := Vector3(0.8, 1.2, 0.8)

# Onready Variables
@onready var model = $Model
#@onready var model_mesh = model.get_mesh()
#@onready var model_material = model_mesh.get_material()
#@onready var animation = $gobot/AnimationPlayer
@onready var spring_arm = %Gimbal

#@onready var particle_trail = $ParticleTrail
#@onready var footsteps = $Footsteps

# Misc Variables

var color:Color = Color(1,1,1,1)

# Floats

var gravity:float = ProjectSettings.get_setting("physics/3d/default_gravity") * 2

# Integers



# Booleans
var is_grounded:bool = false
var can_double_jump:bool = false
var can_attack:bool = false


# ---------- FUNCTIONS ---------- #

func _process(_delta):
	pass
	#model_material.albedo_color = color

func _physics_process(delta):
	player_animations()
	get_input(delta)
	
	# Smoothly follow player's position
	spring_arm.position = lerp(spring_arm.position, position, delta * follow_lerp_factor) + Vector3(cam_pos_offset)
	
	# Player Rotation
	if is_moving():
		var look_direction = Vector2(velocity.z, velocity.x)
		model.rotation.y = lerp_angle(model.rotation.y, look_direction.angle(), delta * 12)
	
	# Check if player is grounded or not
	is_grounded = true if is_on_floor() else false
	
	# Handle Jumping
	if is_grounded:
		can_double_jump = true
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			perform_jump()
		elif can_double_jump:
			if is_moving():
				perform_flip_jump()
	
	velocity.y -= gravity * delta
	
	move_and_slide()
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody3D: 
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
			print("pushed")

func perform_jump():
	#AudioManager.jump_sfx.play()
	#AudioManager.jump_sfx.pitch_scale = 1.12
	
	jumpTween()
	#animation.play("Jump")
	velocity.y = jump_force

func perform_flip_jump():
	#AudioManager.jump_sfx.play()
	#AudioManager.jump_sfx.pitch_scale = 0.8
	#animation.play("Flip", -1, 2)
	velocity.y = jump_force
	#await animation.animation_finished
	can_double_jump = false
	#animation.play("Jump", 0.5)

func is_moving():
	return abs(velocity.z) > 0 || abs(velocity.x) > 0

func jumpTween():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", jumpStretchSize, 0.1)
	tween.tween_property(self, "scale", Vector3(1,1,1), 0.1)

# Get Player Input
func get_input(_delta):
	var move_direction := Vector3.ZERO
	move_direction.x = Input.get_axis("move_left", "move_right")
	move_direction.z = Input.get_axis("move_forward", "move_back")
	
	# Move The player Towards Spring Arm/Camera Rotation
	move_direction = move_direction.rotated(Vector3.UP, spring_arm.rotation.y).normalized()
	velocity = Vector3(move_direction.x * move_speed, velocity.y, move_direction.z * move_speed)

# Handle Player Animations
func player_animations():
	#particle_trail.emitting = false
	#footsteps.stream_paused = true
	
	if is_on_floor():
		if is_moving(): # Checks if player is moving
			pass
			#animation.play("Run", 0.5)
			#particle_trail.emitting = true
			#footsteps.stream_paused = false
		else:
			pass
			#animation.play("Idle", 0.5)
