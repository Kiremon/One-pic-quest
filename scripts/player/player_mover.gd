extends Node

var player :Node2D;
var movement_dir :int;
var is_moving :bool = false;

signal movement_started(move_key);
signal movement_stoped;

func _init(player_node :Node2D) ->void:
	player = player_node;

func has_movement(move_key :int) -> void:
	if is_moving && movement_dir == move_key :
		return;
	
	is_moving = true;
	movement_dir = move_key;
	movement_started.emit(movement_dir);

func no_movement() -> void:
	if !is_moving : return;
	
	is_moving = false;
	movement_stoped.emit();

func make_step(move_key :int, delta: float) ->void:
	var cur_wz :Node = player.get_walkzone();
	var axis :Node = cur_wz.get_axis(move_key);
	
	if axis == null :
		no_movement();
		return;
	
	has_movement(move_key);
	var loc :Node = player.get_loc();
	var step :Vector2 = (
		axis.get_direction(move_key) *
		delta *
		loc.get_speed() *
		axis.get_speed_modifier()
	)
	#а ещё здесь должно быть изменени масштаба, если есть
	var new_position :Vector2 = player.position + step;
	var new_wz :Node = loc.define_walkzone(new_position);
	
	if new_wz == null || loc.is_in_obstacle(new_position) :
		return;
	
	if cur_wz != new_wz:
		player.set_walkzone(new_wz);
	player.position = new_position;

func move_key_check(delta: float) ->void:
	for action in Thesaurus.MOVE_KEYS:
		if Input.is_action_pressed(action):
			make_step(Thesaurus.MOVE_KEYS[action], delta);
			return;
	
	no_movement();#т.е. только если ни одной кнопки не нажато
