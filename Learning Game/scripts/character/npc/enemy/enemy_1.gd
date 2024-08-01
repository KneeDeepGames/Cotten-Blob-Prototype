extends CharacterBody2D

@onready var sprite = $Sprite2D
var attacking:bool = true
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(_delta):
	$Label_Health.text = str($Health_Component.current_health)
	

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if is_on_floor():
		velocity.y += -400
	
	move_and_slide()
