extends Node
class_name HealthComponent

@export var health:int = 10
@export var max_health:int = 10
@export var hurt_delay_time:int = 1

@onready var timer_hurt_delay = $Timer_Hurt_Delay
@onready var current_health:int = health

var died:bool = false

func _ready():
	timer_hurt_delay.wait_time = hurt_delay_time
#
func heal(heal_amount):
	health += heal_amount
	if get_parent().has_method("heal"):
		get_parent().heal()

func hurt(attack: Attack):
	if timer_hurt_delay.is_stopped() and not died:
		timer_hurt_delay.start()
		current_health -= attack.hurt_amount
		if get_parent().has_method("hurt"):
			get_parent().hurt(attack)
		
		if current_health <= 0:
			current_health = 0
			died = true
			if get_parent().has_method("death"):
				get_parent().death(attack)
