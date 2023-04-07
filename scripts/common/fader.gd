extends Node
class_name Fader

var fade_speed :float;
enum FDIRECTIONS {UP = 1, NONE = 0, DOWN = -1};
var fade_direction :int = FDIRECTIONS.NONE;
var object :CanvasItem;
signal faded;

func _init(obj :CanvasItem, speed :float) ->void:
	object = obj;
	set_fade_speed(speed);

func _ready() ->void:
	set_process(false);

func set_fade_speed(speed :float) ->void:
	fade_speed = speed;

func fade_out() ->void:
	object.show();
	object.modulate.a = 1.0;
	fade_direction = FDIRECTIONS.DOWN;
	set_process(true);

func fade_in() ->void:
	object.modulate.a = 0.0;
	object.show();
	fade_direction = FDIRECTIONS.UP;
	set_process(true);

func _process(delta) ->void:
	object.modulate.a += fade_speed * delta * fade_direction;
	if object.modulate.a <= 0.0 || object.modulate.a >= 1.0 :
		if fade_direction == FDIRECTIONS.DOWN:
			object.hide();
		object.modulate.a = 1.0;
		fade_direction = FDIRECTIONS.NONE;
		faded.emit();
		set_process(false);
