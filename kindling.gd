extends "res://interactible.gd"

func _ready():
	icon = preload("res://action.png")

func action():
	if player.add_item($sprite.texture, "kindling"):
		queue_free()