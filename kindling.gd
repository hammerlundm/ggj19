extends "res://interactible.gd"

func _ready():
	icon = preload("res://kindling.png")

func action():
	if player.add_item($sprite.texture, "kindling"):
		queue_free()