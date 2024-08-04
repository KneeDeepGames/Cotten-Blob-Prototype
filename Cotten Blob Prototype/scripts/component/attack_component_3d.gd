extends Area3D
class_name AttackComponent

@export var hurt_amount:int
@export var knockback_power:int
@export var delay_attack:bool = false
@export var attack_delay_time:float = 0.5

@onready var timer_attack_delay = $Timer_Attack_Delay

func _ready():
	timer_attack_delay.set_wait_time(attack_delay_time)

func _on_area_entered(area):
	hurt(area)
	
func hurt(area):
	if area is HitboxComponent and get_parent().can_attack and timer_attack_delay.is_stopped() and area.has_method("hurt"):
		if get_parent().has_method("performed_attack"):
			get_parent().performed_attack()
		if delay_attack:
			timer_attack_delay.start()
		var attack_direction = sign(area.global_position.x - self.global_position.x)
		var attack = Attack.new()
		attack.hurt_amount = hurt_amount
		attack.knockback_power = knockback_power
		attack.attack_direction = attack_direction
		area.hurt(attack)
		
