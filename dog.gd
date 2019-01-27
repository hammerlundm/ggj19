extends "res://interactible.gd"

func _ready():
	icon = preload("res://heart.png")

func action():
	display(preload("res://heart.png"), 2)
	if global.last_score == global.MAX_ITEMS:
		$"..".following = true

func choose_icon():
	if not player.inventory.has(global.todays_food):
		if global.played_today == false:
			display(load("res://" + global.todays_food + ".png"))
		else:
			display(preload("res://broken_heart.png"))

func display(icon, t = 0):
	$"../bubble/icon".texture = icon
	$"../bubble".visible = icon != null
	if t != 0:
		var timer = get_tree().create_timer(t)
		timer.connect("timeout", $"../bubble", "set", ["visible", false])