extends Node

var inventory :Array = [];
var obj_in_hand :String;
var has_obj_in_hand :bool = false;

func add_obj(obj_id :String) ->void:
	#var obj :GameObject = Story.get_object(obj_id);
	assert(!inventory.has(obj_id), "add_obj(): Inventory already has " + obj_id);
	inventory.append(obj_id);
	Ui.update_inventory();

func remove_obj(obj_id :String) ->void:
	assert(inventory.has(obj_id), "remove_obj(): Inventory already has no " + obj_id);
	inventory.erase(obj_id);
	Ui.update_inventory();

#TODO: возможно нужна функция, которая пачкой будет обрабатывать
#запросы на изменение инвентаря, чтобы не дёргать Ui каждый раз

func has_obj(obj_id :String) ->bool:
	return inventory.has(obj_id);

func get_list() ->Array:
	return inventory;

func clear_inv() ->void:
	inventory.clear();
	Ui.update_inventory();

func put_in_hand(obj_id :String) ->void:
	obj_in_hand = obj_id;
	has_obj_in_hand = true;
	Ui.put_in_hand(obj_id);

func free_hand() ->void:
	has_obj_in_hand = false;
	Ui.free_hand();

func is_object_in_hand() ->bool:
	return has_obj_in_hand;

func get_obj_id_in_hand() ->String:
	assert(has_obj_in_hand, "No object in hand!");
	return obj_in_hand;

func _unhandled_input(event :InputEvent) ->void:
	if event.is_action_pressed("lmb"):
		free_hand();
