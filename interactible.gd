extends Area2D

var player_scene = preload("res://player.gd")
var player
var icon

func _ready():
	player = null
	connect("body_entered", self, "on_player_enter")
	connect("body_exited", self, "on_player_exit")

func on_player_enter(body):
	if body is player_scene:
		player = body
		player.object = self
		player.display(icon)

func on_player_exit(body):
	if body is player_scene:
		player = body
		body.object = null
		player.display(null)

func action():
	print("Default action")