extends Node3D

@export var amount:int = 1

var time:float = 0.0
var random_velocity:float = 0.5
var random_time:float = 1

func _process(delta):
	position.y += (cos(time * random_time) * random_velocity) * delta # Sine movement
	time += delta
