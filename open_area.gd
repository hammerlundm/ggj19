extends "res://interactible.gd"

var can_act

func _ready():
	icon = preload("res://door_icon.png")
	can_act = true

func action():
	if can_act and not $"../animation".is_playing():
		var anim
		if player.get_node("collision").global_position.y < $collision.global_position.y:
			anim = "open_out"
		else:
			anim = "open_in"
		can_act = false
		$"../animation".play(anim)
		if anim == "open_out":
			player.anim_offset_inside = 0
			player.dest = $"..".global_position + Vector2(64, 96)
			player.get_node("camera/animation").play_backwards("zoom")
			$"../../roof/animation".play_backwards("fade")
			$"../../../animation".play_backwards("fade")
			$"../../../CanvasLayer/snow".emitting = true
		else:
			player.anim_offset_inside = 14
			player.dest = $"../..".position + Vector2(256, 144)
			$"../../roof/animation".play("fade")
			yield(player, "reached_destination")
			player.get_node("camera/animation").play("zoom")
			$"../../../animation".play("fade")
			$"../../../CanvasLayer/snow".emitting = false
		var t = get_tree().create_timer(2.0)
		t.connect("timeout", $"../animation", "play_backwards", [anim])
		t.connect("timeout", self, "set", ["can_act", true])
