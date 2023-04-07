extends Control

var hint_node :Node;
var speech_node :Node;
var hand_node :Node;
var inv_node :Node;
var block_node :Node;
var curtain_node :Node;
var menu_node :Node;

func register_hint(hint :Node) ->void:
	hint_node = hint;

func register_speech_screen(speech :Node) ->void:
	speech_node = speech;

func register_hand(hand :Node) ->void:
	hand_node = hand;

func register_inv(inv :Node) ->void:
	inv_node = inv;

func register_screen_block(block :Node) ->void:
	block_node = block;

func register_curtain(curtain :Node) ->void:
	curtain_node = curtain;

func register_menu(menu :Node) ->void:
	menu_node = menu;


func on_speech_stoped(action :Callable) ->void:
	speech_node.speech_stoped.connect(action, CONNECT_ONE_SHOT);

func show_hint(hint :String) ->void:
	hint_node.show_hint(hint);

func hide_hint() ->void:
	hint_node.hide_hint();

func start_speech(new_phrases :Array) ->void:
	speech_node.start_speech(new_phrases);

func put_in_hand(obj_id :String) ->void:
	hand_node.take(obj_id);

func free_hand() ->void:
	hand_node.put_away();

func update_inventory() ->void:
	inv_node.update_inv();

func screen_block_on() ->void:
	block_node.show();

func screen_block_off() ->void:
	block_node.hide();

func curtain_close() ->void:
	curtain_node.fade_in();

func curtain_open() ->void:
	curtain_node.fade_out();

func on_curtain_faded(action :Callable) ->void:
	curtain_node.faded.connect(action, CONNECT_ONE_SHOT);

func get_menu() ->Node:
	return menu_node;
