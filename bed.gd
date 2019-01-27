extends "res://interactible.gd"

var main = preload("res://tmp.tscn")

func _ready():
	icon = load("res://x.png")

func on_player_enter(body):
	.on_player_enter(body)

func choose_icon():
	if global.played_today:
		icon = load("res://action.png")

func action():
	if global.played_today:
		$"../objects/bed".disabled = true
		$"../objects/walls".disabled = true
		player.dest = $sprite.global_position + Vector2(0, -48)
		yield(player, "reached_destination")
		var t = get_tree().create_timer(2.0)
		player.set_physics_process(false)
		player.get_node("sprite").frame = 14
		$"../..".set_process(false)
		$"../../CanvasLayer/sunset".material.set_shader_param("et", 1000)
		$"../../animation".playback_speed = 0.5
		$"../../animation".play_backwards("fade")
		yield(t, "timeout")
		get_tree().change_scene_to(main)
