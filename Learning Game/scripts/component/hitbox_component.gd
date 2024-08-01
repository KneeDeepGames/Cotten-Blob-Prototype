extends Area2D
class_name HitboxComponent

@export var health_component:HealthComponent
		
#func heal(health_amount):
	#if health_component:
		#heal(health_amount)
		
func hurt(attack: Attack):
	#printt("hurt",self)
	if health_component:
		health_component.hurt(attack)
