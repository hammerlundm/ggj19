extends Sprite

export(float) var LIFE = 2.0

func _ready():
	pass

func _process(delta):
	modulate.a -= delta/LIFE