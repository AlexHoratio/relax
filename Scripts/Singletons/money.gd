extends Node

var money = 0

#remake all of these into strings some time? 
#had issues with times
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
	"":"-1",
	"rose":"10",
	"violet":"60",
	"chamomile":"600"
}

func _ready():
	money = data.get_value("Money", "money", "10")
	#assigning this var money is kinda useless since most interfacing is done 
	#direct to the configfile
	
func harvest_money(plot_id):
	var plant_type = data.get_value("Plots", plot_id, {"plant_name":""})["plant_name"]
	
	money = str(int(money) + int(rewards[plant_type]))
	data.set_value("Money", "money", money)
	
	