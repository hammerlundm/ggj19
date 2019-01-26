extends StaticBody2D

export(Texture) var img

func _ready():
	$collision.shape.extents = img.get_size()/2.0
	$collision.position = $sprite.position
	$sprite.texture = img
