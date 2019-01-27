extends "res://interactible.gd"

var game = preload("res://QTE.tscn")
var pan = preload("res://pan_icon.png")

func _ready():
	icon = pan

func choose_icon():
	if len(player.inventory) == 0:
		icon = preload("res://x.png")
	elif global.played_today:
		icon = preload("res://check.png")
	else:
		icon = pan

func action():
	if not global.played_today and len(player.inventory) > 0:
		var g = game.instance()
		g.add_items(player.inventory_imgs)
		$"../../../CanvasLayer".add_child(g)
		player.set_physics_process(false)
		player.set_process(false)
		yield(g, "tree_exited")
		player.set_physics_process(true)
		player.set_process(true)
		player.get_node("../CanvasLayer/UI/inventory").queue_free()
		player.display(preload("res://check.png"))