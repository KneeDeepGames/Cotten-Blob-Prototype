extends Area2D
class_name AttackComponent

@export var hurt_amount:int
@export var knockback_power:int
@export var delay_attack:bool = false
@export var attack_delay_time:float = 0.5

@onready var timer_attack_delay = $Timer_Attack_Delay

var attack_direction:int = 0

func _ready():
	timer_attack_delay.set_wait_time(attack_delay_time)

func _on_area_entered(area):
	if get_parent().attacking and timer_attack_delay.is_stopped() and area is HitboxComponent and area.has_method("hurt"):
		attack_direction = sign(self.global_position.x - area.global_position.x)
		var attack = Attack.new()
		attack.hurt_amount = hurt_amount
		attack.knockback_power = knockback_power
		attack.attack_direction = attack_direction
		area.hurt(attack)
		if delay_attack:
			timer_attack_delay.start()
