extends Node

onready var song_count = get_child_count() # Don't have to change anything when you add new music!
var prev_song = -1
var choice = -1

func _ready():
	play_music()
	
func play_music():
	randomize()
	choice = (randi()%song_count)
	while choice == prev_song:
		randomize()
		choice = (randi()%3)
	prev_song = choice
	get_child(choice).play()

func _on_song_finished():
	play_music()
