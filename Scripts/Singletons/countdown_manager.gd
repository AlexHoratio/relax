extends Node

var active_countdowns = []
var total = 0
var just_logged_in = true

func _ready():
	generate_countdowns()
	
func generate_countdowns():
	
	var last_login_time = data.get_value("Data", "last_login_time", OS.get_unix_time())
	var time_difference = OS.get_unix_time() - last_login_time
	
	erase_existing_countdowns()
	for plant in data.get_section_keys("Plots"):
		var countdown = load("res://Scripts/countdown.gd").new()
		countdown.time_left = str(max(float(data.get_value("Plots", plant)["time"]), 0.0))
		
		if(just_logged_in):
			countdown.time_left = str(int(countdown.time_left) - time_difference)
			var data_overwrite = data.get_value("Plots", plant)
			data_overwrite["time"] = str(max(float(countdown.time_left), 0.0))
			data.set_value("Plots", plant, data_overwrite)
			
		countdown.plot_id = plant

		active_countdowns.append(countdown)
		
	just_logged_in = false
		
func erase_existing_countdowns():
	for countdown in active_countdowns:
		countdown.queue_free()
		
	active_countdowns = []
		
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
			
func remove_countdown_by_id(plot_id):
	for countdown in active_countdowns:
		if(countdown.plot_id == plot_id):
			countdown.queue_free()
			active_countdowns.erase(countdown)