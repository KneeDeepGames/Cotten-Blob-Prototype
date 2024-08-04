extends CharacterBody2D
class_name Enemy
#this is the enemy script

@export var patrol_left_limit:float = -1000  # Adjust this value for your patrol range
@export var patrol_right_limit:float = 1000   # Adjust this value for your patrol range

@onready var sprite = $Sprite2D
@onready var state_chart = $StateChart
@onready var timer_patrol = $Timer_Patrol

const speed:int = 250
const accel:int = 25

var can_attack:bool = true
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player = null
var direction_to_player:int = 0
var direction:int = 0
var patrol_direction: int = 1
var patrolling:bool = true
var distance_from_origin:float = 0
var origin: Vector2

func _ready():
	origin = global_position

func _process(_delta):
	distance_from_origin = (global_position.x - origin.x)
	
	#allow attack if moving down
	can_attack = true if velocity.y > 0 else false
	
	$Label_Health.text = str($Health_Component.current_health)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() and velocity.y < 2000:
		velocity.y += gravity * delta
	
	if direction:
		velocity.x = move_toward(velocity.x, speed*direction, accel)
		#printt(velocity.x,self)
	else:
		velocity.x = move_toward(velocity.x, 0, accel)
		
	move_and_slide()

func _on_area_2d_spotted_player_body_entered(body):
	if body.is_in_group("player"):
		state_chart.send_event("player_spotted")
		player = body

func _on_area_2d_lost_player_body_exited(body):
	if body.is_in_group("player"):
		state_chart.send_event("idle")
		player = null

func _on_idle_state_entered():
	print("idle_state_entered")

func _on_idle_state_physics_processing(_delta):
	if timer_patrol.is_stopped():
		patrolling = !patrolling
		timer_patrol.start()
	if patrolling:
		direction = patrol_direction
		if (distance_from_origin <= patrol_left_limit and patrol_direction == -1) or (distance_from_origin >= patrol_right_limit and patrol_direction == 1):
			patrol_direction = -patrol_direction #Reverse direction
	else:
		direction = 0
		
func _on_idle_state_exited():
	direction = 0

func _on_chasing_player_state_entered():
	print("chasing_player_state_entered")

func _on_chasing_player_state_physics_processing(_delta):
	direction_to_player = sign(player.global_position.x - self.global_position.x)
	direction = direction_to_player

func _on_chasing_player_state_exited():
	direction = 0
