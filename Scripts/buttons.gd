extends Node2D

signal harvested_plant

var destination = ""
var current_plot_harvestable = false

func _ready():
	connect("harvested_plant", get_node("../flowerbed"), "harvest_plant_at_plot")
	connect("harvested_plant", countdown_manager, "remove_countdown_by_id")
	#connect("harvested_plant", money, "harvest_money")
	connect("harvested_plant", get_node("../inspector"), "deselect_plot")
	
func _on_harvest_pressed():
	if(current_plot_harvestable):
		var plot = get_node("../flowerbed/plot" + str(get_node("../inspector").selected_plot_id))
		money.harvest_money(get_node("../inspector").selected_plot_id)
		data.erase_value("Plots", get_node("../inspector").selected_plot_id)
		emit_signal("harvested_plant", get_node("../inspector").selected_plot_id)
		#plot.get_node("sprite").queue_free()
		
		

func _process(delta):
	get_node("harvest").disabled = not(current_plot_harvestable)

func _on_relax_pressed():
	destination = "res://Scenes/relax.tscn"
	get_node("../CanvasLayer/ColorRect/AnimationPlayer").play("fade_out")

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene(destination)
