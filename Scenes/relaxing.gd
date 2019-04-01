extends Node2D

var time = 0
var counter = 0

func _ready():
	var time_data = data.get_value("Data", "amount_of_time", "0s")
	if(time_data[time_data.length()-1] == "s"):
		time = 5#int(time_data.substr(0, time_data.length()-1))

func _process(delta):
	
	counter += delta
	if(counter > 1):
		counter -= 1
		time -= 1
	
	var minutes = str(time / 60)
	var seconds = str(time - (int(minutes)*60))
		
	while(minutes.length() < 2):
		minutes = "0" + minutes
			
	while(seconds.length() < 2):
		seconds = "0" + seconds
		
	var formatted_time = minutes + ":" + seconds
	
	get_node("timer").text = formatted_time