extends Control
class_name ObjectSensor

const lmb_name :StringName = &"lmb";
const rmb_name :StringName = &"rmb";

signal lmb_pressed;
signal rmb_pressed;

func _ready() ->void:
	mouse_default_cursor_shape = CURSOR_DRAG;

func _gui_input(event :InputEvent) ->void:
	if event.is_action_pressed(lmb_name):
		lmb_pressed.emit();
	elif event.is_action_pressed(rmb_name):
		rmb_pressed.emit();
