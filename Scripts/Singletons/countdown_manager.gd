extends Node

var active_countdowns = []
var total = 0

func _ready():
	generate_countdowns()
	
func generate_countdowns():
	for plant in data.get_section_keys("Plots"):
		var countdown = load("res://Scripts/countdown.gd").new()
		
		countdown.time_left = data.get_value("Plots", plant)["time"]
		countdown.plot_id = plant

		active_countdowns.append(countdown)
		
func _process(delta):
	total += delta
	if(total > 1):
		total -= 1
		
		for countdown in active_countdowns:
			countdown.time_left = str(int(countdown.time_left) - 1)
			
			if(int(countdown.time_left) <= 0):
				countdown.time_left = "0"
			
			var plot_data = data.get_value("Plots", countdown.plot_id, null)
			plot_data["time"] = countdown.time_left
			data.set_value("Plots", countdown.plot_id, plot_data)
			