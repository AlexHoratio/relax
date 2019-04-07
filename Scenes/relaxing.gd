extends Node2D

var time = 0
var counter = 0
var destination = ""
var finished = false

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
	if(counter > 1 and time > 0):
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
	
	if(time <= 0 and not(finished)):
		finish()
		
func finish():
	finished = true
	#play sound effect
	get_node("alarm").play()
	
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
		get_node("AnimationPlayer").play("new_seed")
		get_node("CanvasLayer/new_seed/seed").texture = load("res://Graphics/Plants/" + get_plant_name_by_id(str(next_unlock)) + ".png")
	else:#we have no more seeds to unlock!
		get_node("CanvasLayer/ColorRect/AnimationPlayer").play("fade_out")
		

func get_plant_name_by_id(plant_id):
	var plant_name = ""
	
	match(plant_id):
		("1"):
			plant_name = "rose"
		("2"):
			plant_name = "violet"
		("3"):
			plant_name = "chamomile"
		("4"):
			plant_name = "sunflower"
		("5"):
			plant_name = "rosebush"
		("6"):
			plant_name = "glooptree"
		("7"):
			plant_name = "fuchsia"
		("8"):
			plant_name = "daisy"
		("9"):
			plant_name = "rafflesia"
		("10"):
			plant_name = "begonia"
		("11"):
			plant_name = "hibiscus"
			
	return plant_name

func _on_AnimationPlayer_animation_finished(anim_name):
	if(anim_name == "fade_out"):
		get_tree().change_scene(destination)

func _on_done_pressed():
	destination = "res://Scenes/garden.tscn"
	get_node("CanvasLayer/ColorRect/AnimationPlayer").play("fade_out")
