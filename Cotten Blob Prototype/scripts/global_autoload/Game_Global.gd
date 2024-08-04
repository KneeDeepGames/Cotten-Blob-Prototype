extends Node

@onready var world = get_tree().get_first_node_in_group("world")
@onready var gui:GUI = world.find_child("GUI")
