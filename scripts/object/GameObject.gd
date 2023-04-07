extends Node
class_name GameObject

#enum PLACES {NONE, LOC, INV};

@export var obj_id :String = "default";
@export var hint :String = "default";
@export var examine_phrases :Array = ["default"];
#@export var place :PLACES = PLACES.NONE;
@export var inv_texture :Texture2D;

func _ready() ->void:
	#перепесь простого списка фраз в приемлемый для speech_handler-а
	#следует рассмотреть вариант экспорта настроек speaker-а
	var true_examine_phrases :Array = [];
	for phrase in examine_phrases:
		true_examine_phrases.append({"text" : phrase});
	examine_phrases = true_examine_phrases;

func get_obj_id() ->String:
	return obj_id;

func get_inventory_texture() ->Texture2D:
	return inv_texture;

func combine_me_with(second_obj_id :String) ->void:
	var combination :Dictionary = Story.get_combination(obj_id, second_obj_id);
	if combination.is_empty():
		combine_failed();
		return;
	if combination.has("speech") :
		start_speech(combination.speech);
	if combination.has("actor") :
		if combination.actor == obj_id:
			call(combination.action);
		else :
			Story.get_object(combination.actor).call(combination.action);

func combine_succeeded() ->void:
	Sound.play_common_sfx("combine_success");

func combine_failed() ->void:
	Sound.play_common_sfx("no_combine");

func check_combine() ->bool:
	var inventory :Node = Story.get_inv();
	if ! inventory.is_object_in_hand():
		return false;
	combine_me_with(inventory.get_obj_id_in_hand());
	inventory.free_hand();
	return true;

func click_me_loc()->void:
	if check_combine():
		return;
	activate_me();

func click_me_inv()->void:
	if check_combine():
		return;
	take_me();

func start_speech(phrases :Array) ->void:
	Ui.start_speech(phrases);

#предполагаемые для перезагрузки функции
func get_hint() ->String:
	return hint;

func examine() ->void:
	start_speech(examine_phrases);

func activate_me() ->void:
	take_me();

func take_me() ->void:
	Story.get_inv().put_in_hand(obj_id);
