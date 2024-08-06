extends Node
class_name CollectableComponent

@export var candy_add_amount:int
@export var type_candy:bool
@export var chocolate_add_amount:int
@export var type_chocolate:bool

func collect():
	if type_candy:
		GameGlobal.collect_candy(candy_add_amount)
	if type_chocolate:
		GameGlobal.collect_chocolate(chocolate_add_amount)
	get_parent().queue_free()

func _on_body_entered(body):
	if body.is_in_group("player"):
		collect()
