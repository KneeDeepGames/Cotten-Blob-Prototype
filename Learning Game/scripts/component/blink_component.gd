extends Node
class_name BlinkComponent

@export_range(0,10) var blink_duration:float = 3.0
@export_range(0,1) var blink_interval:float = 0.1
@export_range(0,1) var blink_brightness_alpha:float = 0.0
@export var gradual_interval_change:bool = false
@export_range(0,10) var time_to_start_gradual_interval_change:float = 2.0
@export_range(0,10) var tween_time_to_change_interval:float = 1.0
@export_range(0,1) var final_blink_interval:float = 0.04

@onready var timer_blink_duration = $Timer_Blink_Duration
@onready var timer_blink_interval = $Timer_Blink_Interval
@onready var timer_gradual_interval_change = $Timer_gradual_interval_change

func _process(_delta):
	if gradual_interval_change:
		timer_blink_interval.set_wait_time(blink_interval)

func _ready():
	timer_blink_duration.set_wait_time(blink_duration)
	timer_blink_interval.set_wait_time(blink_interval)
	timer_gradual_interval_change.set_wait_time(time_to_start_gradual_interval_change)

func start_blink():
	timer_blink_duration.start()
	timer_blink_interval.start()
	if gradual_interval_change:
		timer_gradual_interval_change.start()

func cancel_blink():
	timer_blink_duration.stop()
	timer_blink_interval.stop()
	if gradual_interval_change:
		timer_gradual_interval_change.stop()
	get_parent().sprite.set_self_modulate(Color(1, 1, 1, 1))

func _on_timer_gradual_interval_change_timeout():
	var gradual_blink_brightness_alpha_tween:Tween = get_tree().create_tween()
	gradual_blink_brightness_alpha_tween.tween_property(self,"blink_interval",final_blink_interval,tween_time_to_change_interval)

func _on_timer_hurt_blink_duration_timeout():
	timer_blink_interval.stop() #stops interval timer
	get_parent().sprite.set_self_modulate(Color(1, 1, 1, 1))

func _on_timer_hurt_blink_interval_timeout():
	timer_blink_interval.start() #restarts timer
	print("alternated")
	if get_parent().sprite.get_self_modulate() == Color(1, 1, 1, 1): #alternates color alpha
		get_parent().sprite.set_self_modulate(Color(1, 1, 1, blink_brightness_alpha))
	else:
		get_parent().sprite.set_self_modulate(Color(1, 1, 1, 1))
