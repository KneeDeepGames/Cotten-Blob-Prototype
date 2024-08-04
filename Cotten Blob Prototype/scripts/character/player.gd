extends CharacterBody2D
class_name Player
#this is the player script
@onready var sprite = $Sprite2D

const SPEED = 500.0
const JUMP_VELOCITY = 1000.0

var color:Color = Color(1,1,1,1)
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_attack:bool = true

func performed_attack():
	jump()

func _process(_delta):
	sprite.set_self_modulate(color)
	#allow attack if moving down
	can_attack = true if velocity.y > 0 else false
	
	$Label_Health.text = str($Health_Component.current_health)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() and velocity.y < 2000:
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		#printt(velocity.x,self)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _input(event):
	if event.is_action_pressed("jump"):
		jump()

func jump():
	velocity.y = -JUMP_VELOCITY
