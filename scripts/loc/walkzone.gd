extends Polygon2D


func get_axis(key_id :int) ->Node2D:
	for axis in get_children():
		if axis.has_key(key_id) :
			return axis;
	
	return null;#это срабатывает, если кнопка не задействована

func is_point_in_me(point :Vector2) ->bool:
	return Geometry2D.is_point_in_polygon(point, polygon);
