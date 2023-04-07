extends Node2D

var mover :Node;

var walkzone :Node;
var loc :Node;

func _ready() ->void:
	var mover_class :Script = load(Thesaurus.get_file_path("player_mover"));
	mover = mover_class.new(self);
	$anim.connect_mover(mover);

func place_in_loc(new_loc :Node, pos :Vector2) ->void:
	loc = new_loc;
	position = pos;
	var new_wz :Node = loc.define_walkzone(pos);
	assert((new_wz != null && !loc.is_in_obstacle(pos)), 
			"Стартовая позиция в локации невалидна!");
	set_walkzone(new_wz);
	scale.x = loc.get_player_scale();
	scale.y = scale.x;

func get_walkzone() ->Node:
	return walkzone;

func set_walkzone(new_walkzone :Node) ->void:
	walkzone = new_walkzone;

func get_loc() ->Node:
	return loc;

func _process(delta: float) ->void:
	mover.move_key_check(delta);
