extends Control

var main = preload("res://tmp.tscn")

export(Texture) var up
export(Texture) var down
export(Texture) var action
export(float) var interval = 2.0
export(float) var delay = 3.0

const actions = ["player_up", "player_down", "player_action"]
var images

var next_action
var time
var n_times = 3

func _ready():
	images = [up, down, action]
	time = delay
	next_action = null
	randomize()

func _physics_process(delta):
	time -= delta
	if time <= 0:
		if next_action == null:
			var idx = randi() % len(actions)
			next_action = actions[idx]
			$img.texture = images[idx]
			time = interval
		else:
			next_action = null
			print("you missed!")
			time = delay
			$img.texture = null
			n_times -= 1
	elif next_action != null:
		if Input.is_action_just_pressed(next_action):
			print("you got it!")
			next_action = null
			time = delay
			$img.texture = null
			n_times -= 1
		elif Input.is_action_just_pressed(actions[0]) || \
		     Input.is_action_just_pressed(actions[1]) || \
		     Input.is_action_just_pressed(actions[2]):
				print("you missed!")
				time = delay
				next_action = null
				$img.texture = null
				n_times -= 1
	if n_times <= 0:
		set_physics_process(false)
		get_tree().change_scene_to(main)
