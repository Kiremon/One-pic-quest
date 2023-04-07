extends TextureRect

var obj_node :GameObject;
var to_delete :bool = false;

func _ready() ->void:
	for node in get_children():
		if node is ObjectSensor:
			connect_sensor(node);
	resized.connect(fix_pivot_offset, CONNECT_ONE_SHOT);
	$anim.play("add_me");

func fix_pivot_offset() ->void:
	pivot_offset = size * 0.5;

func set_obj(obj_id :String) ->void:
	obj_node = Story.get_object(obj_id);
	texture = obj_node.get_inventory_texture();

func get_obj_id() ->String:
	return obj_node.get_obj_id();

func set_to_delete(value :bool) ->void:
	to_delete = value;

func need_to_delete() ->bool:
	return to_delete;

func connect_sensor(sensor :Node) ->void:
	sensor.lmb_pressed.connect(activate_me);
	sensor.rmb_pressed.connect(examine);
	sensor.mouse_entered.connect(hint_start);
	sensor.mouse_exited.connect(hint_stop);

func hint_start() ->void:
	Ui.show_hint(obj_node.get_hint());

func hint_stop() ->void:
	Ui.hide_hint();

func activate_me() ->void:
	obj_node.click_me_inv();

func examine() ->void:
	obj_node.examine();

