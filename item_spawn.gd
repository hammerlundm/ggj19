extends Node2D

export(String, "berry", "carrot", "melon", "mushroom", "potato", "pumpkin") var type

var item = preload("res://item.tscn")

func _ready():
	pass

func spawn():
	var i = item.instance()
	i.type = type
	i.global_position = global_position
	get_node("..").call_deferred("add_child", i)
	queue_free()
