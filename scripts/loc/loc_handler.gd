extends Node2D

@export var player_speed :float = 1.0;
@export var player_scale :float = 1.0;

@onready var walkzone_list :Node = $walkzone;
@onready var obstacle_list :Node = $obstacles;
@onready var enter_points :Node = $enter_points;
@onready var chapter :Node = get_parent();
@onready var dynamic_zone :Node = $obj_sort;

func place_player(player :Node, enter_point :int) ->void:
	if enter_point >= enter_points.get_child_count():
		enter_point = 0;
	player.get_parent().remove_child(player);
	dynamic_zone.add_child(player);
	player.place_in_loc(self, enter_points.get_child(enter_point).position);

func define_walkzone(pos :Vector2) -> Node:
	for wz in walkzone_list.get_children():
		if wz.is_point_in_me(pos):
			return wz;
	return null;

func is_in_obstacle(pos :Vector2) -> bool:
	for obstacle in obstacle_list.get_children():
		if Geometry2D.is_point_in_polygon(pos, obstacle.polygon):
			return true;
	return false;

func get_speed() ->float:
	return player_speed;

func get_player_scale() ->float:
	return player_scale;

func get_chapter() ->Node:
	return chapter;
