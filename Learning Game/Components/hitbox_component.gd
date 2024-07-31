extends Area2D
class_name HitboxComponent

@export var health_component:HealthComponent
		
#func heal(health_amount):
	#if health_component:
		#heal(health_amount)
		
func hurt(attack: Attack):
	print("enemy hurt")
	#if disable_on_hit:
		#collision_shape.disabled = true
		#
	if health_component:
		health_component.hurt(attack)
	#
	#if carrot_drop_component:
		#carrot_drop_component.collect()
	
#func _on_body_entered(body):
	#if body is CharacterBody2D:
		#body_collided = body
#
#func _on_body_exited(body):
	#if body is CharacterBody2D:
		#body_collided = null
#
#func _process(_delta):
	#if body_collided:
		#hit()
#
#func hit():
	#if disable_on_hit:
		#collision_shape.disabled = true
		#
	#if carrot_drop_component:
		#carrot_drop_component.collect()
	#
	#if carrot_item:
		#carrot_item.collect()
		#
	#if strawberry_item:
		#strawberry_item.collect()
