extends Node2D

signal harvested_plant

var current_plot_harvestable = false

func _ready():
	connect("harvested_plant", get_node("../flowerbed"), "harvest_plant_at_plot")
	connect("harvested_plant", countdown_manager, "remove_countdown_by_id")
	connect("harvested_plant", money, "harvest_money")
	
func _on_harvest_pressed():
	if(current_plot_harvestable):
		var plot = get_node("../flowerbed/plot" + str(get_node("../inspector").selected_plot_id))
		emit_signal("harvested_plant", get_node("../inspector").selected_plot_id)
		data.erase_value("Plots", get_node("../inspector").selected_plot_id)
		#plot.get_node("sprite").queue_free()
		
		

func _process(delta):
	get_node("harvest").disabled = not(current_plot_harvestable)