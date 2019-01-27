extends StaticBody2D

export(Texture) var img

func _ready():
	var s = img.get_size()
	if s.y > s.x:
		var img2 = img.duplicate()
		var sprite2 = Sprite.new()
		sprite2.texture = img2
		add_child(sprite2)
		sprite2.region_enabled = true
		sprite2.region_rect = Rect2(0, 0, s.x, 2*s.y/3)
		sprite2.z_index = 2
		sprite2.position = $sprite.position
		sprite2.position.y -= s.y/6
		$sprite.position.y += s.y/3
		$sprite.region_enabled = true
		$sprite.region_rect = Rect2(0, 2*s.y/3, s.x, s.y/3)
	$sprite.texture = img
