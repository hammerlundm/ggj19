extends KinematicBody2D

var footprint = preload("res://footprint.tscn")

export(float) var SPEED = 1.0
export(int) var MAX_STAMINA = 100
export(float) var STAMINA_DRAIN = 1.0
export(int) var MAX_INV = 3
export(float) var ANIM_LENGTH = 1.0

var object
var stamina setget set_stamina
var inventory
var kindling
var anim_time
var anim_offset_dir = 0
var anim_offset_inside = 14
var dest
var foot_time
var foot_dir

func _ready():
	add_user_signal("reached_destination")
	object = null
	set_stamina(MAX_STAMINA)
	inventory = []
	kindling = 0
	anim_time = ANIM_LENGTH
	dest = null
	foot_time = 0
	foot_dir = 8

func _physics_process(delta):
	var v
	if dest == null:
		v = Vector2(0, 0)
		if Input.is_action_pressed("player_right"):
			v.x += SPEED
			$sprite.flip_h = false
		if Input.is_action_pressed("player_left"):
			v.x -= SPEED
			$sprite.flip_h = true
		if Input.is_action_pressed("player_down"):
			v.y += SPEED
			anim_offset_dir = 0
		if Input.is_action_pressed("player_up"):
			v.y -= SPEED
			anim_offset_dir = 7
	else:
		var diff = dest - position
		if diff.length_squared() < 5.0:
			dest = null
			emit_signal("reached_destination")
		v = diff.normalized() * SPEED
	set_stamina(stamina - (STAMINA_DRAIN*delta))
	move_and_slide(v * (1 if anim_offset_inside == 0 else 0.75))
	if v.length_squared() > 0:
		foot_time -= delta
		if foot_time <= 0 and anim_offset_inside == 0:
			foot_time = 0.2
			var f = footprint.instance()
			f.global_position = global_position + Vector2(foot_dir, 32)
			foot_dir = -foot_dir
			get_tree().get_root().add_child(f)
			var t = get_tree().create_timer(2.0)
			t.connect("timeout", f, "queue_free")
		anim_time -= delta
		if anim_time <= 0:
			anim_time = ANIM_LENGTH
			$sprite.frame = (($sprite.frame + 1) % $sprite.hframes) + anim_offset_dir + anim_offset_inside
	else:
		$sprite.frame = anim_offset_dir + anim_offset_inside

func _process(delta):
	if object and Input.is_action_just_pressed("player_action"):
		object.action()

func add_item(text, item):
	if item == "kindling":
		kindling += 1
		$"../CanvasLayer/UI/kindling".modulate = Color(kindling / 10.0, kindling / 10.0, kindling / 10.0)
		return true
	else:
		if len(inventory) >= MAX_INV:
			return false
		var img = TextureRect.new()
		img.texture = text
		$"../CanvasLayer/UI/inventory".add_child(img)
		inventory.append(item)
		return true

func display(icon):
	$icon.texture = icon

func set_stamina(val):
	stamina = val
	$"../CanvasLayer/UI/stamina".value = val