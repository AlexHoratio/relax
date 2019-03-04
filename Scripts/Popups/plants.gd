extends Node2D

signal cancel

func _ready():
	pass

func _on_exit_pressed():
	get_node("AnimationPlayer").play("scroll_out")
	emit_signal("cancel")

func _on_AnimationPlayer_animation_finished(anim_name):
	if(anim_name == "scroll_out"):
		queue_free()
