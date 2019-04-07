extends Node2D

signal cancel
signal take_seed

func _ready():
	pass

func _on_exit_pressed():
	emit_signal("cancel")
	get_node("AnimationPlayer").play("scroll_out")

func _on_AnimationPlayer_animation_finished(anim_name):
	if(anim_name == "scroll_out"):
		queue_free()

func _on_buy_pressed():
	if(int(data.get_money()) >= money.investments[get_node("buttons").plant_name]):
		emit_signal("take_seed", [get_node("buttons").plant_name])
		data.set_money(str(int(data.get_money()) - money.investments[get_node("buttons").plant_name]))
		_on_exit_pressed()
		get_node("buy/AudioStreamPlayer").play()
	else:
		get_node("buy/access_denied").play()