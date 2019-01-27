extends Node

var item = preload("res://item_spawn.gd")

export(int) var n_foods = 20

var t = 0
var night = 60

func _ready():
	global.day += 1
	if global.day == 1:
		set_process(false)
	randomize()
	var children = []
	for child in get_children():
		if child is item:
			children.insert(randi()%(len(children) + 1), child)
	var types = []
	for i in range(n_foods):
		types.append(children[i].type)
		children[i].spawn()
	global.todays_food = types[randi()%len(types)]
	$dog/dog_area.display(load("res://" + global.todays_food + ".png"), 2.0)
	$dog/animation.play("idle")
	$cabin/fire/animation.play("fire_" + str(global.warmth()))
	$"CanvasLayer/warm".material.set_shader_param("warmth", global.warmth())
	$"CanvasLayer/sunset".material.set_shader_param("t", night)
	global.played_today = false
	global.n_kindling = 0

func _process(delta):
	t += delta
	if $player.anim_offset_inside == 0 and t >= 5 * night:
		get_tree().change_scene("res://tmp.tscn")
	$world/ParallaxBackground/ParallaxLayer/Sprite4.position.y += 0.2
	$CanvasLayer/sunset.material.set_shader_param("et", t)
	$CanvasLayer/snow.modulate = Color(1.0 - 0.3*(t/night), 1.0 - 0.4*(t/night), 1.0 - 0.2*(t/night), 1)