extends Control

var check_img = preload("res://check.png")
var x = preload("res://x.png")

export(Texture) var up
export(Texture) var down
export(Texture) var action
export(float) var interval = 1.0
export(float) var delay = 3.0

const actions = ["player_up", "player_down", "player_action"]
var images

var next_action
var last_action = null
var time
var n_times
var foods = []
var score = 0
var checks = []

func _ready():
	images = [up, down, action]
	time = delay
	next_action = null
	randomize()
	n_times = len(foods)
	for i in range(n_times):
		var check = TextureRect.new()
		$score.add_child(check)
		check.expand = true
		check.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		check.anchor_right = Control.ANCHOR_END
		check.anchor_bottom = Control.ANCHOR_END
		check.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		check.size_flags_vertical = Control.SIZE_EXPAND_FILL
		check.texture = foods[i].texture
		checks.append(check)
	for food in foods:
		food.position = Vector2(-8 + 20*(2*randf()-1), -14 + 20*(2*randf()-1))

func add_items(items):
	for item in items:
		var s = Sprite.new()
		s.texture = item
		foods.append(s)
		$pan.add_child(s)

func _physics_process(delta):
	for food in foods:
		food.position += 0.05*(Vector2(-8, -14) - food.position + 10*Vector2(2*randf()-1, 2*randf()-1))
	if last_action == "player_up":
		$pan.position.y -= 1.5*sin(2*PI*(delay - time)/delay)
	elif last_action == "player_down":
		$pan.position.y += 1.5*sin(2*PI*(delay - time)/delay)
	elif last_action == "player_action":
		var s = sin(2*PI*(delay - time)/delay) / 20
		$pan.scale += Vector2(s, s)
	time -= delta
	if time <= 0:
		last_action = null
		if next_action == null:
			var idx = randi() % len(actions)
			next_action = actions[idx]
			$img.texture = images[idx]
			time = interval
		else:
			next_action = null
			time = delay
			$img.texture = null
			n_times -= 1
			checks[n_times].texture = x
		if n_times <= 0:
			global.last_score = score
			global.played_today = true
			set_physics_process(false)
			queue_free()
	elif next_action != null:
		if Input.is_action_just_pressed(next_action):
			score += 1
			n_times -= 1
			checks[n_times].texture = check_img
			last_action = next_action
			next_action = null
			time = delay
			$img.texture = null
		elif Input.is_action_just_pressed(actions[0]) || \
		     Input.is_action_just_pressed(actions[1]) || \
		     Input.is_action_just_pressed(actions[2]):
				n_times -= 1
				checks[n_times].texture = x
				time = delay
				next_action = null
				$img.texture = null
