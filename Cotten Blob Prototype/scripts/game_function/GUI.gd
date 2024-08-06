extends CanvasLayer
class_name GUI

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event.is_action_pressed("mouse_visible"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			get_tree().quit()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func update_candy_score(candy_score):
	%Label_Candy_Score.text = str(candy_score)

func update_chocolate_score(chocolate_score):
	%Label_Chocolate_Score.text = str(chocolate_score)
