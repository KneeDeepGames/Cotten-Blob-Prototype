extends Area3D
class_name HitboxComponent

@export var health_component:HealthComponent = null
@export var blink_component:BlinkComponent = null
		
func heal(heal_amount):
	if health_component:
		health_component.heal(heal_amount)
		
func hurt(attack: Attack):
	if health_component:
		health_component.hurt(attack)
