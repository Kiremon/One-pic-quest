extends Control

const lmb_name :StringName = &"lmb";
const rmb_name :StringName = &"rmb";

@onready var text_node :Label = $Label;
@onready var name_node :Label = $Label/name;
var phrases :Array;
var phrase_num :int = -1;

signal speech_stoped;

func _ready() ->void:
	Ui.register_speech_screen(self);

func start_speech(new_phrases :Array) ->void:
	phrases = new_phrases;
	phrase_num = -1;
	next_phrase();
	show();
	Ui.hide_hint();

func stop_speech() ->void:
	hide();
	speech_stoped.emit();

func next_phrase() ->void:
	Sound.stop_speech();
	phrase_num += 1;
	if phrases.size() <= phrase_num:
		stop_speech();
		return;
	
	var phrase :Dictionary = phrases[phrase_num]
	text_node.text = phrase.text;
	var speaker_info :Dictionary;
	if phrase.has("speaker"):
		speaker_info = Thesaurus.get_speaker(phrase.speaker);
		name_node.text = speaker_info.name;
		name_node.add_theme_color_override("font_color", Color(speaker_info.color));
		name_node.show();
	else :
		speaker_info = Thesaurus.get_speaker("default");
		name_node.hide();
	text_node.add_theme_color_override("font_color", Color(speaker_info.color));
	Sound.play_speech(phrase.text);

func _gui_input(event :InputEvent) ->void:
	if (event.is_action_pressed(lmb_name) ||
			event.is_action_pressed(rmb_name)):
		next_phrase();
