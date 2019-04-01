extends Node2D

var formatted_time = "0000"

func _ready():
	pass
	
func _process(delta):
		
	get_node("num1").set_number(formatted_time[3])
	get_node("num2").set_number(formatted_time[2])
	get_node("num3").set_number(formatted_time[1])
	get_node("num4").set_number(formatted_time[0])
		
	#get_node("../buttons").current_plot_harvestable = (str(data.get_value("Plots", selected_plot_id, {"time":"-1"})["time"]) == "0")
	
func get_minutes_seconds_time(unformatted_seconds):
	
	var minutes = str(unformatted_seconds / 60)
	var seconds = str(unformatted_seconds - (int(minutes)*60))
		
	while(minutes.length() < 2):
		minutes = "0" + minutes
			
	while(seconds.length() < 2):
		seconds = "0" + seconds
		
	var formatted_time = minutes + seconds
	
	return formatted_time