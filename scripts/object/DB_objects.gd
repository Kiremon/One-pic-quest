extends Node

@export_file var combinations_file;
var combinations :Dictionary = {};

func _ready() ->void:
	if combinations_file != null :
		var json :JSON = JSON.new();
		var file :FileAccess = FileAccess.open(combinations_file, FileAccess.READ);
		var error :Error = json.parse(file.get_as_text());
		assert(error == OK, "JSON parse error in combinations: " + json.get_error_message());
		if error == OK:
			combinations = json.data;
		
		file = null;

func get_object(id :String) ->GameObject:
	for obj in get_children():
		if obj.get_obj_id() == id :
			return obj;
	
	return null;

func get_combination(obj1 :String, obj2 :String) ->Dictionary:
	if (combinations.has(obj1) && 
			combinations[obj1].has(obj2)):
		return combinations[obj1][obj2];
	if (combinations.has(obj2) && 
			combinations[obj2].has(obj1)):
		return combinations[obj2][obj1];
	return {};
