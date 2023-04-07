extends Node

var sound_handler :Node;
var scenario :Node;

func _ready() ->void:
	scenario = Story.get_scenario_handler();

func get_DB_chapter() ->Node:
	return scenario.get_chapter_handler().get_DB_sounds();

func get_DB_global() ->Node:
	return scenario.get_DB_sounds_global();

func register_sound_handler(handler :Node) ->void:
	sound_handler = handler;

func get_stream_row(id :String) ->AudioStream:
	var stream :AudioStream = get_DB_chapter().get_stream(id);
	if stream == null:
		stream = get_DB_global().get_stream(id);
	return stream;

func get_stream(id :String) ->AudioStream:
	var stream :AudioStream = get_stream_row(id);
	assert(stream != null, "No such sound: " + id);
	return stream;

func play_music(id :String) ->void:
	sound_handler.play_music(get_stream(id));

func play_speech(id :String) ->void:
	var stream :AudioStream = get_stream_row(id);
	#озвучка речи запрашивается автоматически.
	#файлов озвучки может и не быть
	if stream != null :
		sound_handler.play_speech(stream);

func play_sfx(id :String) ->void:
	sound_handler.play_sfx(get_stream(id));

func play_common_sfx(id :String) ->void:
	sound_handler.play_sfx(get_DB_global().get_stream(id));

func stop_music() ->void:
	sound_handler.stop_music();

func stop_speech() ->void:
	sound_handler.stop_speech();

func stop_all() ->void:
	sound_handler.stop_music_urgent();
	sound_handler.stop_speech();
	sound_handler.stop_sfx();
