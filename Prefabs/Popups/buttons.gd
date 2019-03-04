extends Node2D

var plant_name = "rose"

func _ready():
	for button in get_children():
		button.connect("pressed", self, "button_pressed", [button.name])
		
		if(data.get_value("PlantUnlocks", button.name, false)):
			button.disabled = false
			button.get_node("Sprite").visible = true
			
func _process(delta):
		
	plant_name = ""
		
	var button_id = "-1"
	
	for i in get_children():
		if(i.pressed):
			button_id = i.name
			
	match(button_id):
		("1"):
			plant_name = "rose"
		("2"):
			plant_name = "violet"
	
	if(not(button_id == "-1")):
		get_node("../names/" + plant_name).position = get_node("../names/" + plant_name).position.linear_interpolate(Vector2(740, 113), 0.1)
		
	for i in get_node("../names").get_children():
		if(not(i.name == plant_name)):
			i.position = i.position.linear_interpolate(Vector2(740, -112), 0.05)

	#get_node("../name").texture = load("res://Graphics/Plants/BigName/" + plant_name + ".png")
	
		
func button_pressed(button_id):
	for button in get_children():
		if(not(button.name == button_id)):
			button.pressed = false