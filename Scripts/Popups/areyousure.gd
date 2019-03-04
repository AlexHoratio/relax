extends Node2D

signal cancel

func disappear():
	get_node("AnimationPlayer").play("disappear")

func _on_AnimationPlayer_animation_finished(anim_name):
	if(anim_name == "disappear"):
		queue_free()