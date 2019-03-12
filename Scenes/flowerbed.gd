#tool
extends Node2D

func _ready():
	set_plot_textures()
	
	for plot in get_children():
		plot.connect("pressed", self, "plot_pressed", [plot.name.substr(4, plot.name.length() - 4)])
	
#warning-ignore:unused_argument
func _process(delta):
	if(Engine.editor_hint):
		set_plot_textures()
	
func set_plot_textures():
	for plot in get_children():
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
	
		var sprite = Sprite.new()
		sprite.name = "sprite"
		sprite.texture = load("res://Graphics/Plants/" + seed_to_plant + ".png")
		get_node("plot" + plot_id).add_child(sprite)
		sprite.global_position = get_global_mouse_position() + Vector2(0, -5)
		sprite.position = Vector2(int(sprite.position.x), int(sprite.position.y))
			
	for i in get_tree().get_nodes_in_group("cursor_followers"):
		i.queue_free()
		
	get_node("../plant").current_plant_seed = ""