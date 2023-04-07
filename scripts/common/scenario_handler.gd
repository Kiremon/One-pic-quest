extends Node

@export_dir var sounds_global_dir;
@export var scenario_script :Script;

@onready var DB_objects_global :Node = $DB_objects;
@onready var game_node :Node = $game;

var scenario :GameScenario;
var current_chapter :Node;
var story_flags_global :Dictionary;
var DB_sounds_global :Node;

func _ready() ->void:
	var DBs_script :Script = load(Thesaurus.get_file_path("DB_sounds"));
	DB_sounds_global = DBs_script.new(sounds_global_dir);
	scenario = scenario_script.new(self);

func switch_chapter(chapter_file :String) ->void:
	var prefub :PackedScene = load(chapter_file);
	var new_chapter :Node = prefub.instantiate();
	
	remove_current_chapter();
	
	current_chapter = new_chapter;
	game_node.add_child(new_chapter);

func remove_current_chapter() ->void:
	if game_node.get_child_count() > 0 :
		var old_chapter :Node = game_node.get_child(0);
		game_node.remove_child(old_chapter);
		old_chapter.queue_free();
	current_chapter = null;
	Sound.stop_all();
	Story.get_inv().clear_inv();

func get_chapter_handler() ->Node:
	return current_chapter;

func get_DB_objects_global() ->Node:
	return DB_objects_global;

func get_DB_sounds_global() ->Node:
	return DB_sounds_global;

func get_scenario_global() ->GameScenario:
	return scenario;
