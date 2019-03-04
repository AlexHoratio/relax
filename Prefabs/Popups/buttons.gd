extends Node2D

func _ready():
	for button in get_children():
		button.connect("pressed", self, "button_pressed", [button.name])
		
		if(data.get_value("PlantUnlocks", button.name, false)):
			button.disabled = false
			button.get_node("Sprite").visible = true
			
func _process(delta):
	
	var plant_name = ""
	
	var button_id = "-1"
	
	for i in get_children():
		if(i.pressed):
			button_id = i.name
	
	match(button_id):
		("1"):
			plant_name = "rose"
		_: 
			plant_name = "blank"
	
	get_node("../name").texture = load("res://Graphics/Plants/BigName/" + plant_name + ".png")
	
		
func button_pressed(button_id):
	for button in get_children():
		if(not(button.name == button_id)):
			button.pressed = false