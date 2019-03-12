extends Node

onready var data = ConfigFile.new()

func _ready():
	data.load("user://save_data.cfg")
	
func save(junk=""):
	data.save("user://save_data.cfg")
	
func get_value(section, key, default=null):
	return data.get_value(section, key, default)
	
func set_value(section, key, value):
	data.set_value(section, key, value)
	save()
	
func get_section_keys(section):
	return data.get_section_keys(section)
	
	
func get_money():
	return get_value("Money", "money", "10")
	
func set_money(value):
	set_value("Money", "money", value)
	save()