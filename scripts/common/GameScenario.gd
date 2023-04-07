extends RefCounted
class_name GameScenario

var story_flags :Dictionary;
var chapter_handler :Node;

func _init(handler :Node) ->void:
	chapter_handler = handler;
	set_flags();

func set_flags() ->void:
	story_flags = {};

func begin() ->void:
	pass;

func story_flag_exists(flag :String) ->bool:
	return story_flags.has(flag);

func story_has_flag(flag :String) ->bool:
#	assert(story_flags.has(flag),"No such flag in story_flags: " + flag);
	return story_flags[flag];

func story_set_flag(flag :String, value :bool) ->void:
	assert(story_flags.has(flag),"No such flag in story_flags: " + flag);
	story_flags[flag] = value;
