extends Node2D

@export_dir var sounds_dir;
@export var scenario_script :Script;

@onready var DB_objects :Node = $DB_objects;
@onready var locs :Node = $locs;

var scenario :GameScenario;
var DB_sounds :Node;
var player :Node;
var current_loc :Node;

func _ready() ->void:
	var DBs_script :Script = load(Thesaurus.get_file_path("DB_sounds"));
	DB_sounds = DBs_script.new(sounds_dir);
	scenario = scenario_script.new(self);
	
	scenario.begin();

func set_player(new_player :Node) ->void:
	player = new_player;

func get_player() ->Node:
	return player;

func go_to_loc(loc_name :String, enter_point :int) ->void:
	var new_loc :Node = locs.get_node(loc_name);
	assert(new_loc != null, "go_to_loc(): No such loc: " + loc_name);
	if current_loc != null:
		current_loc.hide();
	new_loc.place_player(player, enter_point);
	current_loc = new_loc;
	current_loc.show();

func get_DB_objects() ->Node:
	return DB_objects;

func get_DB_sounds() ->Node:
	return DB_sounds;

func get_scenario() ->GameScenario:
	return scenario;

