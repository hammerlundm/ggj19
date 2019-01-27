extends Node

const MAX_ITEMS = 4

var last_score = -1
var played_today = false
var n_kindling = 0
var day = 0
var todays_food

func _ready():
	pass

func warmth():
	return int(ceil(clamp(n_kindling / 5.0, 0, 3)))