extends Node2D
class_name ObjectHandler

@export var obj_id :String;
var obj_node :GameObject;

const fade_speed :float = 1.0;
var fader :Fader;

func _ready() ->void:
	fader = Fader.new(self, fade_speed);
	add_child(fader);
	var chapter :Node = Story.get_scenario_handler().get_chapter_handler();
	chapter.ready.connect(_after_load, CONNECT_ONE_SHOT);
	for node in get_children():
		if node is ObjectSensor:
			connect_sensor(node);

func _after_load() ->void:
	obj_node = Story.get_object(obj_id);

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
	obj_node.click_me_loc();

func examine() ->void:
	obj_node.examine();

func fade_out() ->void:
	fader.fade_out();

func fade_in() ->void:
	fader.fade_in();


