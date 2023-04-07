extends Node

const file_paths :Resource = preload("res://file_paths.tres");

enum MOVE_KEYS {m_right, m_left, m_up, m_down,
	m_up_right, m_up_left, m_down_right, m_down_left}

const speakers :Dictionary = {
	"default" : { "name" : "", "color" : "#05f7ff" },
	"proto" : { "name" : "S_SPEAKER_PROTO", "color" : "#05f7ff" },
	"customer" : { "name" : "S_SPEAKER_CUSTOMER", "color" : "#0dec22" }
}

func get_move_key(key_id :int) ->String:
	for key in MOVE_KEYS:
		if MOVE_KEYS[key] == key_id:
			return key;
	
	assert(false, "get_move_key() got invalid key id!");
	return "";

func get_speaker(speaker_id :String) ->Dictionary:
	assert(speakers.has(speaker_id), "Thesaurus: no such speaker: " + speaker_id);
	return speakers[speaker_id];

func get_file_path(id :String) ->String:
	return file_paths.get(id);

