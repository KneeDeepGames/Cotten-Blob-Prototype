extends Area2D
class_name AttackComponent

@export var hurt_amount:int
@export var knockback_power:int

var attack_direction:int = 0

@export var attacking:bool = true

func _ready():
	pass

func _process(delta):
	pass

func _on_area_entered(area):
	if attacking and area is HitboxComponent and area.has_method("hurt"):
		attack_direction = sign(self.global_position.x - area.global_position.x)
		var attack = Attack.new()
		attack.hurt_amount = hurt_amount
		attack.knockback_power = knockback_power
		attack.attack_direction = attack_direction
		area.hurt(attack)
