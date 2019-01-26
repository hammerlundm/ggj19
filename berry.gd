extends "res://interactible.gd"

func _ready():
	icon = preload("res://berry.png")

func action():
	if player.add_item(icon, "berry"):
		queue_free()