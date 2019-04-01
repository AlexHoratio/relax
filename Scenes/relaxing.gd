extends Node2D

var time = 0
var counter = 0

func _ready():
	var time_data = data.get_value("Data", "amount_of_time", "0s")
	var numerical_component = int(time_data.substr(0, time_data.length()-1))
	match(time_data[time_data.length()-1]):
		("s"):
			time = numerical_component
		("m"):
			time = numerical_component*60

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
		
	var formatted_time = minutes + seconds
	
	get_node("timer").formatted_time = formatted_time 
	
	if(time <= 0):
		finish()
		
func finish():
	#play sound effect
	#unlock new seed!(display button: see unlock!->shows the unlocked plant in big zoomy sprite)
	#warning-ignore:return_value_discarded

	var unlock_keys = data.get_section_keys("PlantUnlocks")
	
	var highest_lvl_unlocked_seed
	if(not(unlock_keys.size() == 0)):
		highest_lvl_unlocked_seed = unlock_keys[max(unlock_keys.size()-1, 0)]
	else:
		highest_lvl_unlocked_seed = 1
	 
	if(not(int(highest_lvl_unlocked_seed) == 12)):
		var next_unlock = int(highest_lvl_unlocked_seed) + 1
		data.set_value("PlantUnlocks", str(next_unlock), true)
		
	get_tree().change_scene("res://Scenes/garden.tscn")