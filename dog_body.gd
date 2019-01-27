extends KinematicBody2D

var footprint = preload("res://pawprint.tscn")

export(float) var SPEED = 1.0

var following setget follow
var player
var foot_time
var foot_dir

func _ready():
	following = false
	set_physics_process(false)
	player = $"../player"
	foot_time = 0
	foot_dir = 2

func _physics_process(delta):
	var diff = player.position - position
	var v = SPEED * diff.normalized()
	$sprite.flip_h = v.x < 0
	if diff.length() > 100:
		if $animation.current_animation != "walk":
			$animation.play("walk")
		foot_time -= delta
		if foot_time <= 0:
			foot_time = 0.2
			var f = footprint.instance()
			var b = footprint.instance()
			f.global_position = global_position + Vector2(foot_dir - 11, 0)
			b.global_position = global_position + Vector2(foot_dir + 6, 0)
			foot_dir = -foot_dir
			get_tree().get_root().add_child(f)
			get_tree().get_root().add_child(b)
			var t = get_tree().create_timer(2.0)
			t.connect("timeout", f, "queue_free")
		move_and_slide(v)
	else:
		if $animation.current_animation != "idle":
			$animation.play("idle")

func follow(asdf):
	following = asdf
	if following:
		$animation.play("walk")
		set_physics_process(true)
	else:
		$animation.play("idle")
		set_physics_process(false)