extends Node
signal collected_candy(candy_score)

@onready var world = get_tree().get_first_node_in_group("world")
@onready var gui:GUI = world.find_child("GUI")

# Misc Variables



# Floats



# Integers

var candy_score:int = 0
var chocolate_score:int = 0

# Booleans


func collect_candy(candy_add_amount):
	candy_score += candy_add_amount
	gui.update_candy_score(candy_score)
	collected_candy.emit(candy_score)

func collect_chocolate(chocolate_add_amount):
	chocolate_score += chocolate_add_amount
	gui.update_chocolate_score(chocolate_score)
