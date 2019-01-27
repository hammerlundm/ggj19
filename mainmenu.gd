extends Control

var main

func _ready():
	main = load("res://tmp.tscn")
	$HBoxContainer/play.grab_focus()

func on_play():
	get_tree().change_scene_to(main)

func on_quit():
	get_tree().quit()