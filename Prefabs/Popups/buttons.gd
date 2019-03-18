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
		("3"):
			plant_name = "chamomile"
		("4"):
			plant_name = "sunflower"
	
	var time = str(money.times[plant_name])
	if(not(time == "-1")):
		get_node("../stats").modulate.a = lerp(get_node("../stats").modulate.a, 1, 0.1)
		
		get_node("../stats/investment").text = str(money.investments[plant_name])
		get_node("../stats/reward").text = str(money.rewards[plant_name])
		
		var minutes = int(int(time) / 60)
		var seconds = int(time) - (minutes*60)
		
		var hours
		if(minutes > 59):
			hours = int(minutes/60)
			minutes -= hours*60
		else:
			hours = 0
	
		hours = str(hours)
		minutes = str(minutes)
		seconds = str(seconds)
		
		while(hours.length() < 2):
			hours = "0" + hours
			
		while(minutes.length() < 2):
			minutes = "0" + minutes
			
		while(seconds.length() < 2):
			seconds = "0" + seconds
			
		get_node("../stats/time").text = hours + ":" + minutes + ":" + seconds #format this to 00:00:00
	else:
		get_node("../stats").modulate.a = lerp(get_node("../stats").modulate.a, 0, 0.1)
	
	if(not(button_id == "-1")):
		get_node("../names/" + plant_name).position = get_node("../names/" + plant_name).position.linear_interpolate(Vector2(740, 113), 0.1)
		get_node("../descriptions/" + plant_name).modulate.a = lerp(get_node("../descriptions/" + plant_name).modulate.a, 1, 0.1)
		
	for i in get_node("../names").get_children():
		if(not(i.name == plant_name)):
			i.position = i.position.linear_interpolate(Vector2(740, -112), 0.05)
			
	for i in get_node("../descriptions").get_children():
		if(not(i.name == plant_name)):
			i.modulate.a = lerp(i.modulate.a, 0, 0.2)

	#get_node("../name").texture = load("res://Graphics/Plants/BigName/" + plant_name + ".png")
	
		
func button_pressed(button_id):
	for button in get_children():
		if(not(button.name == button_id)):
			button.pressed = false