extends Node

const list_file_name :String = "sounds.json";
var sounds :Dictionary = {};

func _init(dir_input :String) ->void:
	var sounds_dir :String = dir_input + "/";
	var json :JSON = JSON.new();
	var file :FileAccess = FileAccess.open(sounds_dir + list_file_name, FileAccess.READ);
	var error :Error = json.parse(file.get_as_text());
	assert(error == OK, "JSON parse error in sounds: " + json.get_error_message());
	if error == OK:
		sounds = json.data;
	file = null;

	for id in sounds :
		sounds[id] = load(sounds_dir + sounds[id]);

func get_stream(id :String) ->AudioStream:
	if sounds.has(id):
		return sounds[id];
	return null;
