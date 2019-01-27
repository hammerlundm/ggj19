extends Control

var main = preload("res://mainmenu.tscn")

func _ready():
	$HBoxContainer/play.grab_focus()

func on_play():
	get_tree().paused = false
	queue_free()

func on_quit():
	get_tree().change_scene_to(main)