extends "res://interactible.gd"

var type

func _ready():
	icon = load("res://action.png")
	$sprite.texture = load("res://" + type + "_small.png")

func choose_icon():
	if global.played_today || len(player.inventory) == global.MAX_ITEMS:
		icon = load("res://x.png")

func action():
	if player.add_item(load("res://" + type + ".png"), type):
		queue_free()