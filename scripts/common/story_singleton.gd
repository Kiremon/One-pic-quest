extends Node

@onready var scen_handler :Node = $/root/main
var inventory :Node;

func _ready() ->void:
	var inv_script :Script = load(Thesaurus.get_file_path("inventory"));
	inventory = inv_script.new();
	add_child(inventory);

func get_scenario_handler() ->Node:
	return scen_handler;

func get_inv() ->Node:
	return inventory;

#--------работа с объектами--------------------
func get_DB_chapter() ->Node:
	return scen_handler.get_chapter_handler().get_DB_objects();

func get_DB_global() ->Node:
	return scen_handler.get_DB_objects_global();

func get_object(id :String) ->GameObject:
	var obj :GameObject = get_DB_chapter().get_object(id);
	if obj == null:
		obj = get_DB_global().get_object(id);
	
	assert(obj != null, "No such object: " + id);
	return obj;

func get_combination(obj1 :String, obj2 :String) ->Dictionary:
	var combination :Dictionary = get_DB_chapter().get_combination(obj1, obj2);
	if combination.is_empty():
		combination = get_DB_global().get_combination(obj1, obj2);
	
	return combination;


#--------работа с флагами-----------------
func get_scenario_chapter() ->GameScenario:
	return scen_handler.get_chapter_handler().get_scenario();

func get_scenario_global() ->GameScenario:
	return scen_handler.get_scenario_global();

func has_flag(flag :String) ->bool:
	var chapter :GameScenario = get_scenario_chapter();
	if chapter.story_flag_exists(flag):
		return chapter.story_has_flag(flag);
	var global :GameScenario = get_scenario_global();
	if global.story_flag_exists(flag):
		return global.story_has_flag(flag);
	assert(false,"has_flag(): No such story flag: " + flag);
	return false;

func set_flag(flag :String, value :bool) ->void:
	var chapter :GameScenario = get_scenario_chapter();
	if chapter.story_flag_exists(flag):
		chapter.story_set_flag(flag, value);
		return;
	var global :GameScenario = get_scenario_global();
	if global.story_flag_exists(flag):
		global.story_set_flag(flag, value);
		return;
	assert(false,"set_flag(): No such story flag: " + flag);
