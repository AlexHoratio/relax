extends Node2D

var destination = ""

func _ready():
	pass # Replace with function body.

func _on_back_pressed():
	destination = "res://Scenes/garden.tscn"
	get_node("CanvasLayer/ColorRect/AnimationPlayer").play("fade_out")

func _on_AnimationPlayer_animation_finished(anim_name):
	if(anim_name == "fade_out"):
		get_tree().change_scene(destination)

func time_selected(amount_of_time):
	destination = "res://Scenes/relaxing.tscn"
	data.set_value("Data", "amount_of_time", amount_of_time)
	get_node("CanvasLayer/ColorRect/AnimationPlayer").play("fade_out")
