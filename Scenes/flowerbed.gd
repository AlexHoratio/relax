#tool
extends Node2D

var TIME = 0

func _ready():
	set_plot_textures()
	remember_plants()
	
	for plot in get_children():
		if(not(plot == get_node("AudioStreamPlayer"))):
			plot.connect("pressed", self, "plot_pressed", [plot.name.substr(4, plot.name.length() - 4)])
	
#warning-ignore:unused_argument
func _process(delta):
	if(Engine.editor_hint):
		set_plot_textures()
		
	TIME += delta*2
		
	for plot in data.get_section_keys("Plots"):
		if(str(data.get_value("Plots", plot, {"time":1})["time"]) == "0"):
			get_node("plot" + str(plot)).get_node("sprite").position += Vector2(sin(TIME), cos(TIME))*delta
	
func set_plot_textures():
	for plot in get_children():
		if(not(plot == get_node("AudioStreamPlayer"))):
			var plot_id = plot.name.substr(4, plot.name.length() - 4) #string value
			
			var normal = load("res://Graphics/Flowerbed/Plots/plot" + plot_id + "/normal.png")
			var hover = load("res://Graphics/Flowerbed/Plots/plot" + plot_id + "/over.png")
			
			var mask = Image.new()
			mask.load("res://Graphics/Flowerbed/Plots/plot" + plot_id + "/normal.png")
			
			var bmp_mask = BitMap.new()
			bmp_mask.create_from_image_alpha(mask)
			
			normal.flags &= ~Texture.FLAG_FILTER
			hover.flags &= ~Texture.FLAG_FILTER
			
			plot.texture_normal = normal
			plot.texture_hover = hover
			plot.texture_click_mask = bmp_mask
		
func plot_pressed(plot_id):
	var seed_to_plant = get_node("../plant").current_plant_seed
	
	if(not(get_node("plot" + plot_id).has_node("sprite")) and not(seed_to_plant == "")):
	
		var plant_position = get_global_mouse_position() + Vector2(0, -5)
		var plant = generate_plant_at(plot_id, seed_to_plant, plant_position)
	
		var data_to_store = {
			"plant_name":seed_to_plant,
			"time":money.times[seed_to_plant],
			"position":plant.position
		}
		
		data.set_value("Plots", plot_id, data_to_store)
			
	for i in get_tree().get_nodes_in_group("cursor_followers"):
		i.queue_free()
		
	get_node("../plant").current_plant_seed = ""
	
	get_node("../inspector").select_new_plot(plot_id)
	
	countdown_manager.generate_countdowns()
	
	get_node("AudioStreamPlayer").play()
	
func remember_plants():
	for plant in data.get_section_keys("Plots"):
		var plant_type = data.get_value("Plots", plant)["plant_name"]
		var plant_position = data.get_value("Plots", plant)["position"]
		#var plant_time = data.get_value("Plots", plant)["time"]
		
		remember_plant(plant, plant_type, plant_position)
		
	
func generate_plant_at(plot, plant_type, plant_position):
	var sprite = Sprite.new()
	sprite.name = "sprite"
	sprite.texture = load("res://Graphics/Plants/" + plant_type + ".png")
	get_node("plot" + plot).add_child(sprite)
	sprite.global_position = plant_position
	sprite.position = Vector2(int(sprite.position.x), int(sprite.position.y))
	
	return sprite

func remember_plant(plot, plant_type, local_pos):
	var sprite = Sprite.new()
	sprite.name = "sprite"
	sprite.texture = load("res://Graphics/Plants/" + plant_type + ".png")
	get_node("plot" + plot).add_child(sprite)
	sprite.position = local_pos
	
	return sprite
	
func harvest_plant_at_plot(plot_id):
	get_node("plot" + str(plot_id)).get_node("sprite").queue_free()