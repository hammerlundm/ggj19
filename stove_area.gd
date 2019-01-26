extends "res://interactible.gd"

var game = preload("res://QTE.tscn")

func _ready():
	pass

func action():
	get_tree().change_scene_to(game)
