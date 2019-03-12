extends Node

var money = 0

var rewards = {
	"":-1,
	"rose":2,
	"violet":10,
	"chamomile":50
}

var investments = {
	"":-1,
	"rose":1,
	"violet":5,
	"chamomile":25
}

var times = { #in seconds
	"":-1,
	"rose":10,
	"violet":60,
	"chamomile":600
}

func _ready():
	pass #load money from data singleton
	
	
