extends Node2D

func _ready():
	pass

func _on_innoculate_pressed():
	var popup = load("res://Prefabs/Popups/coming_soon.tscn").instance()
	get_node("..").add_child(popup)
