extends Node2D

var selected_plot_id = "-1"
var selected_plant_name = ""

func _ready():
	pass

func _process(delta):
	for plant_name in get_node("names").get_children():
		if(selected_plant_name == plant_name.name):
			plant_name.modulate.a = lerp(plant_name.modulate.a, 1, 0.2)
		else:
			plant_name.modulate.a = lerp(plant_name.modulate.a, 0, 0.2)
	
	var plot_data = data.get_value("Plots", selected_plot_id, {"time":"-1"})
	if(plot_data["time"] == "-1"):
		get_node("time").modulate.a = lerp(get_node("time").modulate.a, 0, 0.2)
		
	else:
		get_node("time").modulate.a = lerp(get_node("time").modulate.a, 1, 0.2)
		var unformatted_seconds = int(plot_data["time"])
		
		var formatted_time
		if(unformatted_seconds >= 3600):
			formatted_time = get_hours_minutes_time(unformatted_seconds)
		else:
			formatted_time = get_minutes_seconds_time(unformatted_seconds)
		
		#get_node("time/Label").text = formatted_time
		
		get_node("time/num1").set_number(formatted_time[3])
		get_node("time/num2").set_number(formatted_time[2])
		get_node("time/num3").set_number(formatted_time[1])
		get_node("time/num4").set_number(formatted_time[0])
		
	get_node("../buttons").current_plot_harvestable = (str(data.get_value("Plots", selected_plot_id, {"time":"-1"})["time"]) == "0")
	
func get_minutes_seconds_time(unformatted_seconds):
	
	var minutes = str(unformatted_seconds / 60)
	var seconds = str(unformatted_seconds - (int(minutes)*60))
		
	while(minutes.length() < 2):
		minutes = "0" + minutes
			
	while(seconds.length() < 2):
		seconds = "0" + seconds
		
	var formatted_time = minutes + seconds
	
	return formatted_time
	
func get_hours_minutes_time(unformatted_seconds):
	
	var hours = str(unformatted_seconds/(60*60))
	var minutes = str((unformatted_seconds / 60) - (int(hours)*60))
	#var seconds = str(unformatted_seconds - (int(minutes)*60))
			
	while(hours.length() < 2):
		hours = "0" + hours
		
	while(minutes.length() < 2):
		minutes = "0" + minutes
		
	var formatted_time = hours + minutes
	
	return formatted_time
	
func select_new_plot(plot_id):
	if(selected_plot_id == plot_id):
		selected_plot_id = "-1"
		selected_plant_name = ""
	else:
		selected_plot_id = plot_id
		var plant = data.get_value("Plots", plot_id, {"plant_name":"", "position":Vector2(0, 0), "time":0})
	
		selected_plant_name = plant["plant_name"]
		
#	for plant_name in get_node("names").get_children():
#		if(plant["plant_name"] == plant_name.name and not(selected_plot_id == "-1")):
#			get_node("names/" + plant_name.name).modulate.a = 1#lerp(get_node("names/" + plant_name).modulate.a, 1, 0.1)
#		else:
#			get_node("names/" + plant_name.name).modulate.a = 0
		
func deselect_plot(plot_id):
	selected_plot_id = "-1"
	selected_plant_name = ""
	
	