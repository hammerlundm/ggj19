extends Sprite

export(float) var ANIM_TIME = 0.2

var anim_offset
var time

func _ready():
	anim_offset = 4 * global.warmth()
	time = ANIM_TIME

func _process(delta):
	anim_offset = 4 * global.warmth()
	time -= delta
	if time <= 0:
		time = ANIM_TIME
		frame = (frame + 1) % 4 + anim_offset
